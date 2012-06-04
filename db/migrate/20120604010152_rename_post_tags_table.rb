class RenamePostTagsTable < ActiveRecord::Migration
  def change
    rename_table :posts_tags, :monologue_posts_tags
  end
end
