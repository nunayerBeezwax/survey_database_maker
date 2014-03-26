require 'active_record'

require './lib/survey'
require './lib/question'

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
    when 'lq'
      list_questions(nil)
    when '+q'
      add_question(nil)
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
       "Enter 'lq' to list questions in a survey.",
       "Enter '+q' to add a question to a survey.",
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

  choice = nil
  until choice == 'm'
    puts "Enter 'lq' to list survey's questions.",
         "Enter 'q' to add a question to #{new_survey.name}",
         "Enter 'm' to return to the Main Menu"
    choice = prompt('Enter choice')

    case choice
    when 'q'
      add_question(new_survey)
    when 'lq'
      list_questions(new_survey)
    when 'm'
      puts 'Returning to main menu'
    end
  end
end

def list_questions(survey)
  if survey.nil?
    list_surveys
    survey_name = prompt('Enter the name of the survey to inspect')
    survey = Survey.find_by_name(survey_name)
  end

  unless survey.nil?
    survey.questions.each do |question|
      puts question.text
    end
    puts "\n\n"
  else
    puts 'Failed to find survey with that name!'
    list_questions(nil)
  end
end

def add_question(survey)
  if survey.nil?
    list_surveys
    survey_name = prompt('Enter the name of the survey to which you would ' +
                     'like to add a question')
    survey = Survey.find_by_name(survey_name)
  end
  unless survey.nil?
    question = prompt('Enter the text of the first question as you want it ' +
                       'to appear on the survey')
    new_question = Question.new({:text => question})
    if new_question.save
      survey.questions << new_question
      puts 'Your question has been added.'
    else
      puts 'Failed to add new question!'
      new_question.errors.full_messages.each { |message| puts message }
      add_question(survey)
    end
  else
    puts 'Failed to find survey with that name!'
    add_question(nil)
  end
end

menu











