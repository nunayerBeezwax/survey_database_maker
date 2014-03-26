require 'active_record'
require 'pry'

class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :choices

  def total_responders
    total = 0
    self.choices.each do |choice|
      total += choice.total_responses
      total += (choice.responses.select(:taker_id).distinct.count)

    end
    total
  end
end
