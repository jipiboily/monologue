require 'spec_helper'

describe Monologue::Post do
  before(:each) do
    @post = Factory(:post)
  end

  it { validate_presence_of(:user_id) }

  it "is valid with valid attributes" do
    @post.should be_valid
  end

  it { validate_presence_of(:title) }
  it { validate_presence_of(:content) }
  it { validate_presence_of(:published_at) }

  it "should create permalink (url) automatically with title and year if none is provided" do
    title = "this is a great title!!!"
    post = Factory(:post, url: "", title: title, published_at: "2012-02-02")
    post.url.should == "2012/this-is-a-great-title"
  end

  it "should not let you create a post with a url starting with a '/'" do
    expect { Factory(:post, url: "/whatever") }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should validate that URLs are unique to a post" do
    post_1 = Factory(:post, url: "unique/url")
    expect { post_1.save }.not_to raise_error()
    expect { Factory(:post, url: "unique/url") }.to raise_error(ActiveRecord::RecordInvalid)
  end


  it "excludes the current post revision on URL uniqueness validation" do
    pr = Factory(:post, url: nil, title: "unique title", published_at: DateTime.new(2011))
    pr.content = "Something changed"
    pr.save
    pr.url.should == "2011/unique-title"
  end

  describe "post's tags" do
    before do
      @post.tag_list = 'new, tags,here'
      @post.save
      @post.reload
    end

    it 'adds tags to post' do
      @post.tags.size.should eq(3)
    end

    it 'update with new tags added' do
      @post.tag_list = 'new, tags, here, plus'
      @post.save
      @post.reload.tags.size.should eq(4)
    end

    it 'removes tags that were removed' do
      @post.tag_list = 'new'
      @post.save
      @post.reload.tags.size.should eq(1)
    end
  end

end
