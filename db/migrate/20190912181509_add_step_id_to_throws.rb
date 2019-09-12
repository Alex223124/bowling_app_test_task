class AddStepIdToThrows < ActiveRecord::Migration[5.2]
  def change
    add_column :throws, :step_id, :integer
  end
end
