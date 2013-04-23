require 'spec_helper'

describe Game do
  let(:game) { build(:game) }
  # let(:user) { game.board_user }
  # let(:comp) { game.board_comp }
  
  it { should have_many :boards }
  
  it "should be valid" do
    game.should be_valid
  end
end
