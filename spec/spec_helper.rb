require 'rspec'
require 'activerecord'

database_configurations = YAML::load(File.open('./db/config.yml'))
ActiveRecord::Base.establish_connection(database_configurations['test'])

RSpec.configure do |config|
  config.after(:each) do
    Survey.all.each { |survey| survey.destroy }
  end
end
