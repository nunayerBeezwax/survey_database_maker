require 'active_record'
require 'pry'

class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :choices

  def total_responders
    total = 0
    respondants = []
    self.choices.each do |choice|
      choice.responses.each do |response|
        respondants << response.taker_id
      end
    end
    total = respondants.uniq.count
  end
end
