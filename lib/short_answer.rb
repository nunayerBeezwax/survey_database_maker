require 'active_record'

class ShortAnswer < ActiveRecord::Base
  belongs_to :survey
end
