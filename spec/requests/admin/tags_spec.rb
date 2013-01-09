require 'spec_helper'
describe "tags" do
  context "creating a post as a logged in user" do
      before(:each) do
        log_in
        visit new_admin_post_path
        fill_in "Title", with:  "title"
        fill_in "Content", with:  "content"
        fill_in "Published at", with:  DateTime.now
      end

      it "should be able to save a post when the tag list ends with with a comma" do
        fill_in "Tags",with: "  rails, ruby, "
        click_button "Save"
        page.should have_field :tag_list ,with: "rails, ruby"
      end

      it "should ignore an empty tag between two commas" do
        fill_in "Tags",with: "  rails, ,ruby"
        click_button "Save"
        page.should have_field :tag_list ,with: "rails, ruby"
      end
  end

end
