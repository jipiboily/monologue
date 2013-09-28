require 'spec_helper'

describe Monologue::Configuration do
  let(:configuration) { Monologue::Configuration.new }

  describe 'Adding a class dynamically to the configuration' do
    class NewConfig
      attr_accessor :prop1, :prop2
    end

    before(:each) do
      configuration.add_class("new_config")
      configuration.new_config = NewConfig.new
    end

    it "should be able to retrieve the settings set dynamically" do
      configuration.new_config.prop1 = "test1"
      configuration.new_config.prop2 = 5

      configuration.new_config.prop1.should == "test1"
      configuration.new_config.prop2.should == 5
    end
  end

end
