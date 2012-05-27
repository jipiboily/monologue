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

  it "should create permalink (url) automaticly with title and year if none is provided" do
    title = "this is a great title!!!"
    post = Factory(:posts_revision, :url => "", :title => title, :published_at => "2012-02-02")
    post.url.should == "2012/this-is-a-great-title"
  end

  it "should not let you create a post with a url starting with a '/'" do
    expect { Factory(:posts_revision,  :url => "/whatever") }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should validate that URLs are unique to a post" do
    post_1 = Factory(:posts_revision, :url => "unique/url").post
    post_1.posts_revisions.build(Factory.attributes_for(:posts_revision, :url => "unique/url"))
    post_1.save.should_not raise_error(ActiveRecord::RecordInvalid)
    expect { Factory(:posts_revision,  :url => "unique/url") }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should generate unique URL" do
    Factory(:posts_revision, :url => nil, :title => "unique title")
    pr = Factory(:posts_revision, :url => nil, :title => "unique title")
    pr.url.should == "2011/unique-title-1"
  end

  it { validate_presence_of(:title) }
  it { validate_presence_of(:content) }
  it { validate_presence_of(:user_id) }
  it { validate_presence_of(:published_at) }
    
end