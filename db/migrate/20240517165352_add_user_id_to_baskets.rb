class AddUserIdToBaskets < ActiveRecord::Migration[6.1]
  def change
    add_reference :baskets, :user, null: false, foreign_key: true
  end
end
