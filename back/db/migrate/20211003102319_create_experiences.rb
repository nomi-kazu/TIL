class CreateExperiences < ActiveRecord::Migration[6.1]
  def change
    create_table :experiences do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :level, null: false, default: 1
      t.integer :lifelong_exp, null: false, default: 0
      t.integer :experience_to_next, null: false, default: 50
      t.timestamps
    end
  end
end
