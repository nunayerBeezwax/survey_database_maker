require 'spec_helper'

describe Response do
  it { should have_and_belong_to_many :choices }
  it { should belong_to :taker }
end
