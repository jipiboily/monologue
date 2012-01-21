class CreateMonologuePosts < ActiveRecord::Migration
  def change
    create_table :monologue_posts do |t|
      t.integer :posts_revision_id
      t.boolean :published
      
      t.timestamps
    end
  end
end
