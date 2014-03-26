require 'active_record'

class Choice < ActiveRecord::Base
  belongs_to :question
  has_many :takers, { :through => :responses }
  has_many :responses
end
