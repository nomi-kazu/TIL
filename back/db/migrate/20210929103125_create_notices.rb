class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|
      t.integer :action_user_id, null: false
      t.integer :received_user_id, null: false
      t.integer :post_id
      t.integer :comment_id
      t.integer :event_id
      t.integer :event_comment_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false
      t.timestamps
    end
  end
end
