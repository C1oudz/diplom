class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :firstname, :string
    add_column :users, :secondname, :string
    add_column :users, :surname, :string
    add_column :users, :role, :int
  end
end
