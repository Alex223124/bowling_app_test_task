class AddFrameIdToThrows < ActiveRecord::Migration[5.2]
  def change
    add_column :throws, :frame_id, :integer
  end
end
