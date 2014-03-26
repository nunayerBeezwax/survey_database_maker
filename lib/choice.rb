require 'active_record'

class Choice < ActiveRecord::Base
  belongs_to :question
  has_and_belongs_to_many :responses

  def total_responses
    total = 0
    binding.pry
    self.responses.each do |response|
      total += 1
    end
    total
  end
end
