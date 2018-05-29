#
# This controller is for static content
#
class ContentController < ApplicationController

  #
  # The main welcome page.  This is a page that shows a video and has a fancy get started wizard.
  #   We don't even really allow logged in users to see this page, they go right to their
  #   recipe page.
  #
  #
  def index
    redirect_to recipe_index_path if @current_user.present?
  end

  #
  # Display a page that highlights how to use the alexa skill.
  #
  def help
  end

  #
  # A terms of service page
  #
  def terms
  end

  #
  # A privacy policy page
  #
  def privacy
  end

end
