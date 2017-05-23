class AddIsAnalyzeToQuestionnaire < ActiveRecord::Migration[5.0]
  def change
    add_column :questionnaires, :is_analyze, :boolean, default: false
  end
end
