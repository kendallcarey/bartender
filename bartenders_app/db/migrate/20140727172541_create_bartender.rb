  class CreateBartender < ActiveRecord::Migration
    def change
      create_table :bartenders do |t|
      t.belongs_to :bar
      t.string :name
      t.string :specialty

      t.timestamps
    end
  end
end
