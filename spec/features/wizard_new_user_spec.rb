require "rails_helper"

RSpec.feature "A new user meets the wizard", :type => :feature do

  before(:all) do
    Capybara.current_driver = :selenium
  end

  after(:all) do
    Capybara.use_default_driver
  end

  scenario "A user walks through the wizard and all is good" do

    # Load the page, and create an account
    visit "/"

    fill_in :id => "signup-name", :with => "Monica Geller"
    fill_in :id => "signup-email", :with => "monica@friends.com"
    fill_in :id => "signup-password", :with => "secret"
    click_button "Create Account"

    expect(page).to have_text("ingredients")

    # Add some ingredients to a new recipe
    fill_in :id => "recipe-name", :with => "greens eggs plus"
    fill_in :id => "pending-ingredient-name", :with => "eggs"
    fill_in :id => "pending-ingredient-quantity", :with => "2"

    find("#pending-ingredient-plus", visible: false).click

    expect(page).to have_text("eggs")

    # Add some steps to a new recipe
    fill_in :id => "pending-step-description", :with => "fry the eggs"
    find("#pending-step-plus", visible: false).click

    expect(page).to have_text("fry")

    click_button "Save New Recipe"
    expect(page).to have_text("Please say the following commands")
    # Now we complete the alexa linking stage


    find("#alexa-link-success-button").click
    expect(page).to have_text("what are the ingredients")

    find("#wizard-complete-button").click
    expect(current_url).to include("recipe")
  end


end