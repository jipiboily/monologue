require 'spec_helper'

describe Monologue::User do
  it { validate_presence_of(:name) }
  it { validate_presence_of(:email) }
  it { validate_uniqueness_of(:email) }

  context "delete user" do
    let(:user_without_post) { stub_model(Monologue::User) }
    let(:user_with_post) do
      user = stub_model(Monologue::User)
      user.stub(:posts => [stub_model(Monologue::Post)])
      user
    end

    let(:user) { Monologue::User.new }

    it "should be able to delete another user that does not have any posts" do
      user.can_delete?(user_without_post).should be_true
    end

    it "should not be able to delete itself" do
      user.can_delete?(user).should be_false
    end

    it "should not be able to delete a user with posts" do
      user.can_delete?(user_with_post).should be_false
    end
  end

end
