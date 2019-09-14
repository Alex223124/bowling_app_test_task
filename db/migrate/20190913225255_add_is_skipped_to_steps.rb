class AddIsSkippedToSteps < ActiveRecord::Migration[5.2]
  def change
    add_column :steps, :is_skipped, :boolean, default: false
  end
end
