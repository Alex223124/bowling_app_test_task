class CreateThrows < ActiveRecord::Migration[5.2]
  def change
    create_table :throws do |t|
      t.integer :number_of_knocked_down_pins
      t.boolean :is_strike
      t.boolean :is_spare

      t.timestamps
    end
  end
end
