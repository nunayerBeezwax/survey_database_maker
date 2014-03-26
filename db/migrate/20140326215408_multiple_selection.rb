class MultipleSelection < ActiveRecord::Migration
  def change
    create_table :choices_responses do |t|
      t.belongs_to :choice
      t.belongs_to :response

      t.timestamps
    end

    remove_column :responses, :choice_id
  end
end
