class AddReasonWhySkippedToSteps < ActiveRecord::Migration[5.2]
  def change
    add_column :steps, :reason_why_skipped, :string
  end
end
