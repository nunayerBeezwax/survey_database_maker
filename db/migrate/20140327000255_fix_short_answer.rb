class FixShortAnswer < ActiveRecord::Migration
  def change
    change_table :short_answers do |t|
      t.remove :survey_id
      t.belongs_to :surveys
    end

  end
end
