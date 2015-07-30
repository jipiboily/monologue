require 'spec_helper'

describe Monologue::ApplicationHelper do
  describe "creating the url for a given tag" do
    before(:each) do
      @tag= Factory(:tag, name: 'my_tag')
    end

    it "should return a well formed url for the tag" do
      helper.tag_url(@tag).should eq "#{Monologue::Engine.routes.url_helpers.root_path}tags/my_tag"
    end
  end

  describe "resolving the absolute image url" do
    it "should create the fully qualified url for a relative url" do
      controller.request.host = 'www.domain.com'
      helper.absolute_image_url('/image.png').should eq "http://www.domain.com/image.png"
    end

    it "should returns the url for an absolute url" do
      url ='https://mydomain.com/image.png'
      helper.absolute_image_url(url).should eq url
    end
  end

  describe "creating the sidebar section for a title and a block" do
    before(:each) do
      @content = "this is the content"
      @result = helper.sidebar_section_for('my title') do
        @content
      end
    end

    it "should create the section header with the title" do
      @result.should include('my title')
    end

    it "should add the content of the block" do
      @result.should include(@content)
    end
  end

  describe "social icons+links" do
    context "render if enabled" do
      it "generate rss <link> tag for <head>" do
        helper.rss_head_link.should have_css(
          "link",
          href: "http://test.host/feed",
          rel: "alternate",
          title: "RSS",
          type: "application/rss+xml"
        )
      end

      it "generate rss icon" do
        helper.rss_icon.should have_css(
          "a",
          href: "http://test.host/feed",
          class: "social",
          target: "_blank"
        )

        helper.rss_icon.should have_css("i", class: "foundicon-rss")
      end

      it "generate github" do
        helper.github_icon.should have_css(
          "a",
          href: "http://github.com/#{Monologue::Config.github_username}",
          class: "social",
          target: "_blank"
        )

        helper.github_icon.should have_css("i", class: "foundicon-github")
      end

      it "generate twitter" do
        helper.twitter_icon.should have_css(
          "a",
          href: "http://twitter.com/#{Monologue::Config.twitter_username}",
          class: "social",
          target: "_blank"
        )

        helper.twitter_icon.should have_css("i", class: "foundicon-twitter")
      end

      it "generate linkedin" do
        helper.linkedin_icon.should have_css(
          "a",
          href: "#{Monologue::Config.linkedin_url}",
          class: "social",
          target: "_blank"
        )

        helper.linkedin_icon.should have_css("i", class: "foundicon-linkedin")
      end

      it "generate googleplus" do
        helper.googleplus_icon.should have_css(
          "a",
          href: "#{Monologue::Config.google_plus_account_url}",
          class: "social",
          target: "_blank"
        )

        helper.googleplus_icon.should have_css("i", class: "foundicon-google-plus")
      end

      it "generate facebook" do
        helper.facebook_icon.should have_css(
          "a",
          href: "#{Monologue::Config.facebook_url}",
          class: "social",
          target: "_blank"
        )

        helper.facebook_icon.should have_css("i", class: "foundicon-facebook")
      end
    end

    context "do not render if disabled" do

      it "do not generate rss icon" do
        Monologue::Config.show_rss_icon = nil
        helper.rss_icon.should eq nil
        Monologue::Config.show_rss_icon = false
        helper.rss_icon.should eq nil
      end

      it "do not generate github" do
        Monologue::Config.github_username = nil
        helper.github_icon.should eq nil
        Monologue::Config.github_username = false
        helper.github_icon.should eq nil
      end

      it "do not generate twitter" do
        Monologue::Config.twitter_username = nil
        helper.twitter_icon.should eq nil
        Monologue::Config.twitter_username = false
        helper.twitter_icon.should eq nil
      end

      it "do not generate linkedin" do
        Monologue::Config.linkedin_url = nil
        helper.linkedin_icon.should eq nil
        Monologue::Config.linkedin_url = false
        helper.linkedin_icon.should eq nil
      end

      it "do not generate googleplus" do
        Monologue::Config.google_plus_account_url = nil
        helper.googleplus_icon.should eq nil
        Monologue::Config.google_plus_account_url = false
        helper.googleplus_icon.should eq nil
      end

      it "do not generate facebook" do
        Monologue::Config.facebook_url = nil
        helper.facebook_icon.should eq nil
        Monologue::Config.facebook_url = false
        helper.facebook_icon.should eq nil
      end
    end


  end

  describe "calculating the label size for a tag" do
    it "should return 1 if the min value is inferior to the max" do
      tag = mock_model(Monologue::Tag, frequency: 5)
      helper.size_for_tag(tag, 5, 4).should eq 1
    end

    it "should return 1 if the min value is equal to the max" do
      tag = mock_model(Monologue::Tag, frequency: 3)
      helper.size_for_tag(tag, 3, 3).should eq 1
    end

    it "should return 1 for a value equal to min" do
      tag = mock_model(Monologue::Tag, frequency: 3)
      helper.size_for_tag(tag, 3, 7).should eq 1
    end

    it "should return number of label sizes for a value equal to max" do
      tag = mock_model(Monologue::Tag, frequency: 7)
      helper.size_for_tag(tag, 3, 7).should eq 5
    end

    it "should return a logarithmic scaling between min and max for a value strictly in the given interval" do
      tag = mock_model(Monologue::Tag, frequency: 6)
      helper.size_for_tag(tag, 3, 7).should > 1
      helper.size_for_tag(tag, 3, 7).should < 5 #helper.NUMBER_OF_LABEL_SIZES
    end

  end
end
