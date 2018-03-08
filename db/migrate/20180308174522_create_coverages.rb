class CreateCoverages < ActiveRecord::Migration[5.1]
  def change
    create_table :coverages do |t|
      t.string :operator
      t.float :latitude
      t.float :longitude
      t.string :g2
      t.string :g3
      t.string :g4

      t.timestamps
    end
  end
end
