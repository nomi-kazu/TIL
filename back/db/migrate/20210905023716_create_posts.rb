class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false
      t.string :title, null: false, :limit => 50
      t.text :content, null: false
      t.time :study_time, null: false
      t.timestamps
    end
  end
end
