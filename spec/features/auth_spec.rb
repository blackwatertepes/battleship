require 'spec_helper'

feature "Visitor who hasn't signed in" do
  scenario "should not be able to get past the homepage" do
    visit play_path
    current_path.should eq root_path
  end
end

feature "Visitor signs up" do
  let(:user) { build(:user) }

  scenario "with valid name/email" do
    sign_up_with(user.name, user.email)
    current_path.should eq play_path
  end

  scenario "with invalid email" do
    sign_up_with(user.name, "joe@mail.c")
    current_path.should eq root_path
  end
end

feature "Logged in user" do
  let(:user) { build(:user) }
  
  scenario "should be able to logout" do
    sign_up_with(user.name, user.email)
    click_link("Logout")
    visit play_path
    current_path.should eq root_path
  end
end

def sign_up_with(name, email)
  visit root_path
  fill_in "user_name", with: name
  fill_in "user_email", with: email
  click_button "Play"
end
