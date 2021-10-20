class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false
      t.text :content
      t.time :study_time, null: false
      t.datetime :study_date, null: false
      t.timestamps
    end
  end
end
