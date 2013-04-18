# require 'spec_helper'

# feature "A player without a game in progess" do
#   before(:all) do
#     user = create(:user)
#     sign_up_with(user.name, user.email)
#   end

#   # scenario "should refresh to see a new game" do
#   #   click_link "New Game"
#   #   expect(page.has_css?(".hit")).to be_false
#   #   expect(page.has_css?(".miss")).to be_false
#   # end
# end

# feature "A player with a game in progress" do
#   # before(:all) do
#   #   user = create(:user)
#   #   sign_up_with(user.name, user.email)
#   # end
# end

# def sign_up_with(name, email)
#   visit root_path
#   fill_in "user_name", with: name
#   fill_in "user_email", with: email
#   click_button "Play"
# end
