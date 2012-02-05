require 'spec_helper'
describe "posts" do
  before(:each) do
    user = Factory(:user)
    posts = 0
    25.times do
      revisions = 0
      posts+=1
      @post = Factory(:post)
      3.times do 
        revisions+=1
        @post.posts_revisions.build(Factory.attributes_for(:posts_revision, user_id: user.id, url: "/monologue/post/#{posts}" , title: "post #{posts} | revision #{revisions}"))
      end
      @post.save
    end
  end
  
  it "lists posts" do
    visit root_path
    page.should have_content("post 3 | revision 3")
    page.should_not have_content("post 3 | revision 2")
    page.should_not have_content("post 3 | revision 1")
    page.should_not have_content("post 20")
  end
  
  it "should route to a post" do
    visit root_path
    click_on "post 3 | revision 3"
    page.should have_content("this is some text with french accents")
    page.should_not have_content("post 3 | revision 2")
  end
  
  it "has a feed" do
    visit feed_path
    page.should_not have_content("post 3 | revision 2")
    page.should have_content("post 3 | revision 3")
  end
end