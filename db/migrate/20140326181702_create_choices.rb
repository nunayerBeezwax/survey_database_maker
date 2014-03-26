class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.column :content, :string
      t.belongs_to :question

      t.timestamps
    end
  end
end
