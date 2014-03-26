require 'active_record'
require 'pry'

class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :choices

  def total_responses
    total = 0
    self.choices.each do |choice|
      total += choice.responses.count
    end
    total
  end
end
