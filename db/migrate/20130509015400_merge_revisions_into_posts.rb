class MergeRevisionsIntoPosts < ActiveRecord::Migration
  class Monologue::PostsRevision < ActiveRecord::Base
    attr_accessible :title, :content, :url, :published_at, :post_id
  end

  def up
    add_column :monologue_posts, :title, :string
    add_column :monologue_posts, :content, :text
    add_column :monologue_posts, :url, :string
    add_column :monologue_posts, :published_at, :datetime
    remove_column :monologue_posts, :posts_revision_id
    #add_index :monologue_posts, :url, unique: true

    Monologue::Post.reset_column_information

    Monologue::Post.all.each do |post|
      latest_revision =  latest_revision_for(post)
      post.title =latest_revision.title
      post.content =latest_revision.content
      post.url =latest_revision.url
      post.published_at =latest_revision.published_at
      post.save!
    end
  end

  def down
    remove_column :monologue_posts, :title
    remove_column :monologue_posts, :content
    remove_column :monologue_posts, :url
    remove_column :monologue_posts, :published_at
  end

  private
    def latest_revision_for(post)
      Monologue::PostsRevision.where("post_id = ?", post.id).order("monologue_posts_revisions.updated_at DESC").limit(1).first
    end
end
