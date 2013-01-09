# encoding: UTF-8
require 'spec_helper'
describe "users" do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    log_in

  end

  it "make sure the link to user edit screen is present", js: true, driver: :webkit do
    click_link I18n.t("layouts.monologue.admin.nav_bar.edit_user_info")
  end

  context "edit" do
    before do
      visit edit_admin_user_path(user)
    end

    it "validates user name is present" do
      fill_in "user_name", with: ""
      click_button "Save"
      page.should have_content("Name is required")
    end

    it "validates email is present" do
      fill_in "user_email", with: ""
      click_button "Save"
      page.should have_content("Email is required")
    end
    it "validates user password and confirmation match" do
      fill_in "user_password", with: "password"
      fill_in "user_password", with: "password2"
      click_button "Save"
      page.should have_content(I18n.t("activerecord.errors.models.monologue/user.attributes.password.confirmation"))
    end

    it "doesn't change password if none is provided" do
      password_before = ::Monologue::User.find_by_email(user.email).password_digest
      click_button "Save"
      ::Monologue::User.first.password_digest.should eq(password_before)
    end
  end
end