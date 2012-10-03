  require 'spec_helper'

describe Monologue::Post do
  before(:each) do
    @post = Factory(:post)
  end

  it "is valid with valid attributes" do
    @post.should be_valid
  end
    
  describe "validations" do    
    it "is not possible to have twice the same posts_revision_id" do
      Factory(:post, :posts_revision_id => 1)
      expect { Factory(:post, :posts_revision_id => 1) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

end
#
#describe "Post with revisions tototototo" do
#  #WHY???
#  before(:each) do
#    @post = Factory(:post_with_multiple_revisions)
#  end
#
#  it "should be able to retrieve the active revision" do
#    #WHY do I have to do that
#     attr = Factory.attributes_for(:posts_revision)
#     attr[:id] = 2
#     attr[:post_id] = @post.id
#     rev = @post.posts_revisions.create(attr)
#     @post.active_revision.should eq rev
#   end
#end
