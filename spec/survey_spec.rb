require 'spec_helper'

describe Survey do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  it 'should have a capitalized name in the database' do
    test_survey = Survey.create({ :name => 'foo' })
    test_survey.name.should eq 'Foo'
  end

  it { should have_many :questions }
end
