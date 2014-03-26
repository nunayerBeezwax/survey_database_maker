require 'active_record'

class Response < ActiveRecord::Base
  has_and_belongs_to_many :choices
  belongs_to :taker
end
