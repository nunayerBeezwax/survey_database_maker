require 'rspec'
require 'active_record'
require 'active_record_migrations'
require 'pg'
require 'shoulda-matchers'

require 'survey'
require 'question'
require 'choice'
require 'taker'
require 'response'
require 'short_answer'

database_configurations = YAML::load(File.open('./db/config.yml'))
ActiveRecord::Base.establish_connection(database_configurations['test'])

I18n.enforce_available_locales = false

RSpec.configure do |config|
  config.after(:each) do
    Survey.all.each { |survey| survey.destroy }
    Question.all.each { |question| question.destroy }
    Choice.all.each { |choice| choice.destroy }
  end
end
