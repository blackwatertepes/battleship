require 'spec_helper'

describe Board do
  let(:board) { build(:board) }
  
  it { should validate_presence_of :width }
  it { should validate_presence_of :height }
  it { should validate_presence_of :game }
  it { should validate_presence_of :user }
  
  it { should belong_to :game }
  it { should belong_to :user }
  it { should have_many :ships }
  
  it "should be valid" do
    board.should be_valid
  end
end
