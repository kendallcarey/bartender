  class CreateCreateBartenderTable < ActiveRecord::Migration
    def change
      create_table :createbartendertables do |t|
      t.belongs_to :bar
      t.string :name
      t.string :specialty

      t.timestamps
    end
  end
end
