class AddIndexToPostsRevisionUrl < ActiveRecord::Migration
  def change
    add_index :monologue_posts_revisions, :url
  end
end
