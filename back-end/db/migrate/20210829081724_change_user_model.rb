class ChangeUserModel < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :age, :integer
    remove_column :users, :dob, :date
  end
end
