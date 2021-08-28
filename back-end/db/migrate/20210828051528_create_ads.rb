class CreateAds < ActiveRecord::Migration[6.1]
  def change
    create_table :ads do |t|
      t.text :content
      t.string :creator

      t.timestamps
    end
  end
end
