class JoinRevisionsAndTags < ActiveRecord::Migration
  def change
     create_table :posts_revisions_tags, :id=>false do |t|
       t.integer :posts_revision_id,:tag_id
     end

   end
end
