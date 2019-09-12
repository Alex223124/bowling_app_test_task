class AddPlayerIdToFrames < ActiveRecord::Migration[5.2]
  def change
    add_column :frames, :player_id, :integer
  end
end
