class CreateExperienceRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :experience_records do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, foreign_key: true 
      t.integer :obtained_exp, null: false
      t.float :bonus_multiplier, default: 1
      t.timestamps
    end
  end
end
