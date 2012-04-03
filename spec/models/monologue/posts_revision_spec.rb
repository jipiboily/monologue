# encoding: UTF-8
require 'spec_helper'

describe Monologue::PostsRevision do
  before(:each) do
    @post = Factory(:post_with_multiple_revisions)
  end

  it { should_not allow_mass_assignment_of(:user_id) }
  
  it "can have more than one revision" do
    attr = Factory.attributes_for(:posts_revision)
    attr[:id] = 2
    @post.posts_revisions.create(attr)
  end
  
  it "is always the latest revisions that is current one on post" do
    attr = Factory.attributes_for(:posts_revision)
    attr[:id] = 2
    @post.posts_revisions.create(attr)
    post = Monologue::Post.last
    post.posts_revision_id.should equal(post.posts_revisions.last.id)
  end

  it { validate_presence_of(:title) }
  it { validate_presence_of(:content) }
  it { validate_presence_of(:user_id) }
  it { validate_presence_of(:published_at) }
    
end
