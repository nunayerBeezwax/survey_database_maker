require 'spec_helper'

describe Choice do
  it { should belong_to :question }
  it { should have_and_belong_to_many :responses }
end
