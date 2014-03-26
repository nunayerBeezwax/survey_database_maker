class AddTakersAndResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.belongs_to :choice
      t.belongs_to :taker

      t.timestamps
    end

    create_table :takers do |t|
      t.column :name, :string

      t.timestamps
    end
  end

end
