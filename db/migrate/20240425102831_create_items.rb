class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :title
      t.integer :ostatok
      t.string :address
      t.integer :buyprice
      t.integer :sellprice

      t.timestamps
    end
  end
end
