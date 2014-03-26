require 'active_record'

require './lib/survey'
require './lib/question'
require './lib/choice'
require './lib/response'
require './lib/taker'

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
    # when '+c'
      # add_choice(nil)
    when 'lt'
      list_takers
    when '+t'
      add_taker
    when 'ts'
      take_survey
    when 'r'
      show_results
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
       "Enter 'lt' to list survey participants.",
       "Enter '+t' to add survey participant.",
       # "Enter '+c' to add an answer choice for a question.",
       "Enter 'ts' to take a survey.",
       "Enter 'r' to see the results of a survey.",
       "Enter 'x' to exit."
end

def list_surveys
  puts '** List of Surveys **'
  Survey.all.each do |survey|
    puts "\t#{survey.name}"
  end
  print '*'*21, "\n"
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
    puts "#{survey.name}"
    survey.questions.each do |question|
      puts "\t#{question.text}"
      question.choices.each do |choice|
        puts "\t#{choice.number}: #{choice.content}"
      end
      puts
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
    question = prompt('Enter the text of the question as you want it ' +
                       'to appear on the survey')
    new_question = Question.new({:text => question})
    if new_question.save
      survey.questions << new_question
      puts 'Your question has been added.'
      continue = nil
      number = 1
      until continue == 'n'
        add_choice(new_question, number)
        continue = prompt('Continue adding answer choices? (y/n)').downcase
        number += 1
      end
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

def add_choice(question, choice_number)
  content = prompt('Enter text for answer choice')
  new_choice = Choice.new({ :content => content, :number => choice_number })
  if new_choice.save
    question.choices << new_choice
    puts
  else
    puts 'Failed to save answer choice!'
    add_choice(question, choice_number)
  end
end

def list_takers
  Taker.all.each do |taker|
    puts "#{taker.name}"
  end
end

def add_taker
  name = prompt('Enter participant name')
  new_taker = Taker.new({ :name => name })
  if new_taker.save
    puts "Added #{new_taker.name} to participant list."
  else
    puts 'Failed to add new participant!'
    add_taker
  end
end

def take_survey
  taker_name = prompt('Enter your name')
  taker = Taker.find_by_name(taker_name)
  puts "Enter the name of the survey you would like to take"
  survey_name = prompt('Survey name')
  survey = Survey.find_by_name(survey_name)
  survey.questions.each do |question|
    puts "\t#{question.text}"
    question.choices.each do |choice|
      puts "\t#{choice.number}: #{choice.content}"
    end
    taker_choice = prompt('Enter the number of your choice').to_i
    choice = (question.choices.select {|choice| choice.number == taker_choice}).first
    new_response = Response.create({ :choice_id => choice.id, :taker_id => taker.id })
  end
end

def show_results
  survey_name = prompt('Enter the name of the survey to see its results')
  survey = Survey.find_by_name(survey_name)
  survey.questions.each do |question|
    puts "#{question.text}"
    question.choices.each do |choice|
      puts "#{choice.content}"
      puts "#{choice.responses.count} people selected that choice, which constitutes"
      puts "#{(choice.responses.count.to_f / question.total_responses.to_f) * 100}% of the participants."
    end
  end
end

menu











