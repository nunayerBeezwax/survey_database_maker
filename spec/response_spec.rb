require 'spec_helper'

describe Response do
  it { should belong_to :choice }
  it { should belong_to :taker }
end
