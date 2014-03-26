require 'spec_helper'

describe Taker do
  it { should have_many :choices }
  it { should have_many :responses }
  it { should validate_uniqueness_of :name }
end
