class RecipeController < ApplicationController

  before_action :verify_signed_in

  #
  # The main recipes page for a user.
  #
  def index
    @recipes = @current_user.recipes.includes(:ingredients, :steps)

    respond_to do |format|
      format.html {}
      format.json {
        render json: {
          success: true,
          recipes: @recipes.as_json(:include => [:ingredients, :steps], methods: :pretty_day)
        }
      }
    end
  end

  #
  # This action um, creates a new recipe record for a usere,
  #
  def create

    result = {success: false}

    begin
      ActiveRecord::Base.transaction do
        recipe = Recipe.create!(
          :user_id => @current_user.id,
          :name => params[:name]
        )

        raise "A recipe must have at least one step" if params[:steps].to_a.select {|i| i.present?}.blank?
        params[:steps].to_a.each_with_index do |step, i|
          Step.create!(
            :recipe_id => recipe.id,
            :position => i,
            :description => step['description']
          )
        end

        raise "A recipe must have at least one ingredient" if params[:ingredients].to_a.select {|i| i.present?}.blank?
        params[:ingredients].to_a.each_with_index do |ingredient, i|
          Ingredient.create!(
            :recipe_id => recipe.id,
            :name => ingredient['name'],
            :quantity => ingredient['quantity'],
            :position => i
          )
        end

        result = {success: true, name: recipe.name} if recipe.id.present?

      end
    rescue StandardError => e
      result = {success: false, error: e}
    end

    render json: result
  end

  #
  # Update an existing recipe.
  #
  def update
    result = {success: false}
    begin
      ActiveRecord::Base.transaction do

        recipe = Recipe.find params[:id]
        recipe.update_attributes(:name => params[:name])

        recipe.steps.delete_all
        raise "A recipe must have at least one step" if params[:steps].to_a.blank?
        params[:steps].to_a.each_with_index do |step, i|
          Step.create!(
            :recipe_id => recipe.id,
            :position => i,
            :description => step['description']
          )
        end

        recipe.ingredients.delete_all
        raise "A recipe must have at least one ingredient" if params[:ingredients].to_a.blank?
        params[:ingredients].to_a.each_with_index do |ingredient, i|
          Ingredient.create!(
            :recipe_id => recipe.id,
            :name => ingredient['name'],
            :quantity => ingredient['quantity'],
            :position => i
          )
        end

        result = {success: true, name: recipe.name} if recipe.id.present?

      end
    rescue StandardError => e
      result = {success: false, error: e}
    end

    render json: result
  end

  #
  # Delete a recipe, or raise an error.
  #
  def destroy
    recipe = Recipe.find params[:id]
    recipe.destroy
    render json: {success: true}
  end

end
