require 'spec_helper'

describe User do
  let(:user) { build(:user) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  # it { should have_many :games }

  it "should be valid" do
    user.should be_valid
  end

  it "should validate email format" do
    build(:user, email: "joe@mail.c").should_not be_valid
    build(:user, email: "joeatmail.com").should_not be_valid
  end
end
