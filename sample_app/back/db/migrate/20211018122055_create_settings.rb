class CreateSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :settings do |t|
      t.references :user, null: false,  foreign_key: true
      t.boolean :notice_post_like, default: true
      t.boolean :notice_comment, default: true
      t.boolean :notice_follow, default: true
      t.timestamps
    end
  end
end
