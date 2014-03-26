require 'active_record'

require './lib/survey'

database_configurations = YAML::load(File.open('./db/config.yml'))
ActiveRecord::Base.establish_connection(database_configurations['development'])

I18n.enforce_available_locales = false

def menu
  puts 'Welcome to the Survey UI!'
  choice = nil

  until choice == 'x'
    print_options
    choice = prompt('Enter choice')

    case choice
    when 'ls'
      list_surveys
    when '+s'
      add_survey
    when 'x'
      puts 'Good-bye!'
    else
      puts 'Invalid option! Try again.'
    end
  end
end

def prompt(string)
  print string + ': '
  gets.chomp
end

def print_options
  puts "Enter 'ls' to list surveys in catalog.",
       "Enter '+s' to add survey to catalog.",
       "Enter 'x' to exit."
end

def list_surveys
  Survey.all.each do |survey|
    puts survey.name
  end
  puts "\n\n"
end

def add_survey
  name = prompt('Enter the name of the survey')
  new_survey = Survey.new({:name => name})
  if new_survey.save
    puts "The #{new_survey.name} survey has been added."
  else
    puts 'Failed to create new survey!'
    new_survey.errors.full_messages.each { |message| puts message }
    add_survey
  end
end

menu











