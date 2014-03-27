class CreateShortAnswer < ActiveRecord::Migration
  def change
    create_table :short_answers do |t|
      t.column :response, :string
      t.belongs_to :survey

      t.timestamp
    end
  end
end
