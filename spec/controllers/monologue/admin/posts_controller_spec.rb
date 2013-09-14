require 'spec_helper'

describe Monologue::Admin::PostsController do
  let(:user) { create(:user) }
  before do
    sign_in_as user
    # before(:each) { @routes = Monologue::Engine.routes }
    @routes = Monologue::Engine.routes
  end

  describe 'PUT #update' do
    let(:post) { create(:post) }
    let(:new_content) { 'This is the new content, for real!' }
    let(:new_title) { 'nothing to do, I find it awesome!' }

    context :valid do
      before do
        put :update,
          id: post.id,
          post: {
            content: new_content,
            title: new_title
          }
      end

      it { expect(post.reload.content).to eq new_content }
      it { expect(post.reload.title).to eq new_title }
    end

    # context :invalid do
    #   before do
    #   end
    # end
  end
end
