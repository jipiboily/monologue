require 'spec_helper'

describe Monologue::ApplicationHelper do
  describe "creating the url for a given tag" do
    before(:each) do
      @tag= Factory(:tag, :name => 'my_tag')
    end

    it "should return a well formed url for the tag" do
      helper.tag_url(@tag).should == "#{Monologue::Engine.routes.url_helpers.root_path}tags/my_tag"
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

  describe "calculating the label size for a tag" do
    it "should return 1 if the min value is inferior to the max" do
      tag = mock_model(Monologue::Tag, :frequency=> 5)
      helper.size_for_tag(tag, 5, 4).should == 1
    end

    it "should return 1 if the min value is equal to the max" do
      tag = mock_model(Monologue::Tag, :frequency=> 3)
      helper.size_for_tag(tag, 3, 3).should == 1
    end

    it "should return 1 for a value equal to min" do
      tag = mock_model(Monologue::Tag, :frequency=> 3)
      helper.size_for_tag(tag, 3, 7).should == 1
    end

    it "should return number of label sizes for a value equal to max" do
      tag = mock_model(Monologue::Tag, :frequency=> 7)
      helper.size_for_tag(tag, 3, 7).should == 5
    end

    it "should return a logarithmic scaling between min and max for a value strictly in the given interval" do
      tag = mock_model(Monologue::Tag, :frequency=> 6)
      helper.size_for_tag(tag, 3, 7).should > 1
      helper.size_for_tag(tag, 3, 7).should < 5 #helper.NUMBER_OF_LABEL_SIZES
    end

  end
end