require 'active_record'

class Choice < ActiveRecord::Base
  belongs_to :question
end
