class AddFrameIdToPoints < ActiveRecord::Migration[5.2]
  def change
    add_column :points, :frame_id, :integer
  end
end
