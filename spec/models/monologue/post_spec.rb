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
