require 'spec_helper'

describe Monologue::PostsRevision do
  before(:each) do
    @post = Factory(:post)
    @post.posts_revisions.build(Factory.attributes_for(:posts_revision))
  end

  it "is valid with valid attributes" do
    @post.posts_revisions.first.should be_valid
  end
  
  it "can have more than one revision" do
    attr = Factory.attributes_for(:posts_revision)
    attr[:id] = 2
    @post.posts_revisions.create(attr)
  end
    
  describe "validations" do
    ["url", "title", "content", "post_id", "user_id", "published_at"].each do |req|
      it "requires a #{req}" do
        eval("@post.posts_revisions.first.#{req} = nil")
        @post.should_not be_valid
      end
    end
    
    it "is not possible to have twice the same posts_revision_id" do
      expect { Factory(:post) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
