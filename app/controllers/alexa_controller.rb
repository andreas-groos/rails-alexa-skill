class AlexaController < ApplicationController

  skip_before_action :verify_authenticity_token

  #
  #
  #
  def ask
    
    begin
      AlexaVerifier.valid!(request)
    rescue AlexaVerifier::InvalidCertificateURIError, AlexaVerifier::InvalidCertificateError, AlexaVerifier::InvalidRequestError
      render plain: 'Invalid Request', status: 400 and return
    end

    @input = AlexaRubykit.build_request(params)

    #AlexaVerifier::InvalidCertificateURIError	Raised when the certificate URI does not pass validation.
    #AlexaVerifier::InvalidCertificateError	Raised when the certificate itself does not pass validation e.g. out of date, does not contain the requires SAN extension, etc.
    #AlexaVerifier::InvalidRequestError	Raised when the request cannot be verified (not timely, not signed with the certificate, etc.)

    output = AlexaRubykit::Response.new
    session_end = (@input.type == "SESSION_ENDED_REQUEST")

    set_slot_params
    set_user_and_recipe

    # session = Session.find_or_initialize_by(session_id: input.session.session_id)
    message = case @input.type
      when "LAUNCH_REQUEST" then launch
      when "SESSION_ENDED_REQUEST" then session_end
      when "INTENT_REQUEST" then handle_intent
      else
        "There was an error."
    end

    output.add_speech(message)
    render json: output.build_response(session_end)
  end
  
  private
  
  #
  # Ok this is where our alexa "routing" happens.  The request has been
  #   parsed, and we're ready to process the request type to generate a
  #   response, so the call the appropriate "action."
  #
  def handle_intent

    # If there is no alexa_user, and the intent is anything other than linkaccount,
    #   we won't be able to respond.  If voice recipe input is enabled someday,
    #   this will need to change.
    return "please visit repeatmyrecipes.com and follow the pass phrase instructions to link your account" if (@input.name != 'linkaccount' && @alexa_user.blank?)

    # Handle the intent by calling a method based on the intent name
    return case @input.name
      when "linkaccount" then link_account
      when "listrecipes" then list
      when "reciterecipe" then recite
      when "ingredients"   then ingredients
      when "ingredientlookup" then ingredient_lookup
      when "steps"  then steps
      when "steplookup" then step_lookup
      else
        "I'm not sure what that means.  Try cooking up another request"
    end
  end

  #
  # Attaches an alexa user id to a user in repeat my recipes.
  #
  #   Responds to intents like "my voice is my passport 1234"
  #
  def link_account
    u = User.where("codeword ilike ?", "%#{@slot_params['codeword']}%")
            .where(:amazon_user_identifier => nil)
            .where("not exists (select * from users where amazon_user_identifier = ?)", @input.session.user['userId'])
            .order("created_at desc")
            .first
    Rails.logger.info "Unable to connect your account with code #{@slot_params['codeword']}, please check that the code number is correct."
    return "Unable to connect your account with code #{@slot_params['codeword']}, please check that the code number is correct." if u.blank?

    u.update_attributes!(:amazon_user_identifier => @input.session.user['userId'])
    return "Your account has been linked.  I am ready to repeat your recipes."
  end

  #
  # Top level list of all of a user's recipes.
  #
  #   Responds to questions like "what are my recipes?"
  #
  def list
    @recipes = @alexa_user.recipes

    if @recipes.length == 0
      return "I do not know any of your recipes, head to repeatmyrecipes.com to add your cookbook."
    elsif @recipes.length > 10
      return "You have #{@recipes.length} recipe#{'s' if @recipes.length != 1} available.  Would you like me to list them?"
    else
      return "Your recipes are #{ @recipes.map {|i| i.name}.join(",") }."
    end

    return alexa_response
  end

  #
  # This is going to say the recipe name, and all the ingredients and all the steps.
  #
  def recite
    ingredients = @recipe.ingredients.map { |i| "#{i.quantity} #{i.name}" }
    steps = @recipe.steps.map { |i| "#{i.description}"}

    return <<-STATEMENT
      Your #{@recipe.name} ingredients are #{ingredients.to_sentence}.
      To prepare, #{steps.to_sentence}
    STATEMENT
  end

  #
  # List all the ingredients in a recipe.
  #
  #   Responds to questions like "What are the ingredients in my guacamole recipe?"
  #
  def ingredients
    ingredients = @recipe.ingredients.map { |i| "#{i.quantity} #{i.name}" }
    return <<-STATEMENT
      Your #{@recipe.name} ingredients are #{ingredients.to_sentence}.
    STATEMENT
  end

  #
  # List all the steps in a recipe.
  #
  #  Responds to questions like "what are the steps in my guacamole recipe?"
  #
  def steps
      steps = @recipe.steps.map { |i| "#{i.description}"}

    return <<-STATEMENT
      To prepare your #{@recipe.name} recipe, #{steps.to_sentence}
    STATEMENT
  end

  #
  # Looks up the quantity of a specific ingredient in a recipe.
  #
  #   Responds to questions like "how much paprika is in my chilli recipe?"
  #
  def ingredient_lookup
    @ingredient = @recipe.ingredients.order(Arel.sql("name <-> #{sanitize @slot_params['ingredient']}")).first
    return "Sorry, I'm unable to find #{@slot_params['recipename']} in your #{@recipe.name} recipe." if @ingredient.blank?

    return "#{@ingredient.quantity}"

  end

  #
  # Helps a user remember a specific step in a recipe.
  #
  #   Responds to questions like "what do I do after I dice the jalapeno?"  TODO, use full text search to find the prior step.
  #
  def step_lookup
    @prior_step = @recipe.steps.order(Arel.sql("description <-> #{sanitize @slot_params['cookingaction']}")).first
    @next_step = @recipe.steps.where("position > ?", @prior_step.position).order("position asc").first
    return @next_step.description
  end

  
  #
  # This is where the application is loaded by a user.  If they have not yet linked their account,
  #   then we don't have any recipes to give them.
  #
  def launch
    return "I am ready to repeat your recipes." if @alexa_user.present?
    return "Please follow the instructions at repeatmyrecipes.com to link your account."
  end
  
  #
  #
  #
  def session_end
    return "Bon Apetite."
  end

  #
  # Because almost all "asks" are going to need to lookup the user and a recipe, we do that here,
  #   by setting @alexa_user and @recipe instance variables.
  #
  #   We note that this is like a set_user before_action, but it is outside
  #     the normal rails route/action paradigm. TODO, consider set_current_user update.
  #
  def set_user_and_recipe
    @alexa_user = User.where(:amazon_user_identifier => @input.session.user['userId']).first if @input.session.user['userId'].present?
    @recipe = @alexa_user.recipes.order(Arel.sql("name <-> #{sanitize @slot_params['recipename']}")).first if @slot_params['recipename'].present?
  end
  
  
  #
  # Convert the slots into a ruby hash key => value
  #
  def set_slot_params
    # returns all the intent slots
    # e.g. {"generic" => "what they said", "schedule_date" => "2016-12-05"}
    return @slot_params if @slot_params

    @slot_params = {}
    return @slot_params unless @input.type == "INTENT_REQUEST"

    @input.slots.each do |name, slot|
      key = name.underscore # category_noun, etc
      value = slot['value']
      @slot_params[key] = value
    end if @input.slots.present?

    return @slot_params
  end

end
