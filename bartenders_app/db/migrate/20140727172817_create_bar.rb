  class CreateBar < ActiveRecord::Migration
    def change
      create_table :bars do |t|
      t.string :name
      t.string :location
      t.integer :phone_number
      t.integer :rating
      t.string :category_filter
      t.integer :radius_filter
      t.boolean :is_closed
      t.string :image_url

      t.timestamps
    end
  end
end
