require 'spec_helper'

describe Salvo do
  let(:salvo) { build(:salvo) }
  
  it { should validate_presence_of :x }
  it { should validate_presence_of :y }
end
