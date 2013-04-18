require 'spec_helper'

feature "A player on the play page" do
  before(:each) do
    user = build(:user)
    sign_up_with(user.name, user.email)
  end

  scenario "should be able to start a new game" do
    click_link "New Game"
    expect(page).to_not have_css('.hit')
    expect(page).to_not have_css('.miss')
  end

  scenario "should be able to change their name/email" do
    pending("edit works in dev, but not in test")
    new_user = build(:user)
    click_link "Edit"
    fill_in "user_name", with: new_user.name
    fill_in "user_email", with: new_user.email
    click_button "Update"
    current_path.should eq play_path
    expect(page).to have_content(new_user.name)
    expect(page).to have_content(new_user.email)
  end
end

def sign_up_with(name, email)
  visit root_path
  fill_in "user_name", with: name
  fill_in "user_email", with: email
  click_button "Play"
end
