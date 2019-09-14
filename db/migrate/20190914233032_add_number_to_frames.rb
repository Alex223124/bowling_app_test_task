class AddNumberToFrames < ActiveRecord::Migration[5.2]
  def change
    add_column :frames, :number, :integer
  end
end
