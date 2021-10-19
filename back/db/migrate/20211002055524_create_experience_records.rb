class CreateExperienceRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :experience_records do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, foreign_key: true 
      t.integer :obtained_exp, null: false, comment: "獲得経験値"
      t.timestamps
    end
  end
end
