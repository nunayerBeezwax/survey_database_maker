class FixQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :surveys_id
    add_column :questions, :survey_id, :integer
  end
end
