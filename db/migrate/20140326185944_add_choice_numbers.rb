class AddChoiceNumbers < ActiveRecord::Migration
  def change
    add_column :choices, :number, :integer
  end
end
