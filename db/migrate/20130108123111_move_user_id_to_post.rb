class MoveUserIdToPost < ActiveRecord::Migration
  class Monologue::PostsRevision < ActiveRecord::Base
  end

  class Monologue::Post < ActiveRecord::Base
    has_many :posts_revisions
  end

  def up
    add_column :monologue_posts, :user_id, :integer
    Monologue::Post.reset_column_information
    Monologue::Post.all.each do |post|
      post.user_id = post.posts_revisions.first.user_id
      post.save(validate: false)
    end
    remove_column :monologue_posts_revisions, :user_id
  end

  def down
    add_column :monologue_posts_revisions, :user_id, :integer
    Monologue::Post.reset_column_information
    Monologue::Post.all.each do |post|
      post.posts_revisions.each do |revision|
        revision.user_id = post.user_id
        revision.save!
      end
    end
    remove_column :monologue_posts, :user_id
  end
end
