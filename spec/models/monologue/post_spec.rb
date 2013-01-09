  require 'spec_helper'

describe Monologue::Post do
  before(:each) do
    @post = Factory(:post)
  end

  it { should_not allow_mass_assignment_of(:user_id) }

  it { validate_presence_of(:user_id) }

  it "is valid with valid attributes" do
    @post.should be_valid
  end

  describe "validations" do
    it "is not possible to have twice the same posts_revision_id" do
      Factory(:post, posts_revision_id: 1)
      expect { Factory(:post, posts_revision_id: 1) }.to raise_error(ActiveRecord::RecordInvalid)
    end
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
