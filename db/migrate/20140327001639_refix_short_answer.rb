class RefixShortAnswer < ActiveRecord::Migration
  def change
    change_table :short_answers do |t|
      t.remove :surveys_id
      t.belongs_to :survey
    end
  end
end
