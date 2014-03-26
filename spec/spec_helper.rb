require 'rspec'
require 'active_record'
require 'active_record_migrations'
require 'pg'
require 'shoulda-matchers'

require 'survey'

database_configurations = YAML::load(File.open('./db/config.yml'))
ActiveRecord::Base.establish_connection(database_configurations['test'])

I18n.enforce_available_locales = false

RSpec.configure do |config|
  config.after(:each) do
    Survey.all.each { |survey| survey.destroy }
  end
end
