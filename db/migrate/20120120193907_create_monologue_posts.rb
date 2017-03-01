class CreateMonologuePosts < ActiveRecord::Migration
  def change
    create_table :monologue_posts do |t|
      t.boolean :published
      t.string :title
      t.text :content
      t.string :url
      t.integer :user_id
      t.datetime :published_at
      t.timestamps
    end

    add_index :monologue_posts, :url, unique: true
  end
end
