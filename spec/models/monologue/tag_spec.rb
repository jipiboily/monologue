require 'spec_helper'

describe Monologue::Tag do
  before(:each) do
    @tag= Factory(:tag)
  end

  it "is valid with valid attributes" do
    @tag.should be_valid
  end

  describe "validations" do
    it "is not possible to have save another tag with the same name" do
       expect { Factory(:tag) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "should require the name to be set" do
      expect { Factory(:tag,:name=>nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

end