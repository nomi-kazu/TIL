class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false, index: true
      t.string :name, limit: 100, null: false
      t.text :content, null: false
      t.boolean :public, null: false, default: true, comment: "公開・非公開"
      t.timestamps
    end
  end
end
