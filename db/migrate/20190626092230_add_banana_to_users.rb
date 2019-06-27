class AddBananaToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :banana, :integer
  end
end
