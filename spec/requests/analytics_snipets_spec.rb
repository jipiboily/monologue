# encoding: UTF-8
require 'spec_helper'
describe "analytics code snipets" do
  describe "gauge" do
    it "generate gauge snippet if site exists" do
      Monologue::Config.gauge_analytics_site_id = "gauge id here"
      visit root_path
      page.should have_content("t.setAttribute('data-site-id', 'gauge id here');")
    end

    it "does not generate gauge snippet if no site id has been set" do
      Monologue::Config.gauge_analytics_site_id = nil
      visit root_path
      page.should_not have_content("t.setAttribute('data-site-id'")
    end
  end

  describe "google analtycs" do
    it "generate GA snippet if site exists" do
      Monologue::Config.google_analytics_id = "GA id"
      visit root_path
      page.should have_content("_gaq.push(['_setAccount', 'GA id'")
    end

    it "does not generate GA snippet if no site id has been set" do
      Monologue::Config.google_analytics_id = nil
      visit root_path
      page.should_not have_content("_gaq.push(['_setAccount', ")
    end
  end

end