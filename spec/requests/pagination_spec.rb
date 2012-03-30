# encoding: UTF-8
require 'spec_helper'
describe "pagination" do
  before(:each) do
    user = Factory(:user)
    posts = 0
    41.times do
      revisions = 0
      posts+=1
      @post = Factory(:post)
      2.times do 
        revisions+=1
        # puts "post ##{posts}"
        @post.posts_revisions.build(Factory.attributes_for(:posts_revision, user_id: user.id, url: "/monologue/post/#{posts}" , title: "post #{posts} | revision #{revisions}"))
      end
      @post.save
    end

    @posts_per_page = 10 # TODO: should be set the same as the model's per_page
  end

  it "should not show all posts" do
    visit root_path
    page.should_not have_content("post #{@posts_per_page + 1}")
  end

  it "can go to older posts" do
    visit root_path
    home_page = page.html
    click_on "Older posts"
    page.html.should_not eq(home_page)
  end

  it "can go to newer posts" do
    visit "#{root_path}page/2"
    page_2 = page.html
    click_on "Newer posts"
    page.html.should_not eq(page_2)
  end

  it "should not show 'newer posts' on first page" do
    visit root_path
    page.should_not have_content("Newer posts")
  end

  it "should not show 'older posts' on last page" do
    visit (root_path + "page/5")
    page.should_not have_content("Older posts")
  end
end