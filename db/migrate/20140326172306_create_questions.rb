class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|

      t.belongs_to :surveys
      t.column :text, :string

      t.timestamps
    end
  end
end
