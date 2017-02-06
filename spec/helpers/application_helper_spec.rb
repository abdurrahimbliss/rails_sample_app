require 'spec_helper'

describe ApplicationHelper do

  describe "full_title" do

    it "should have the page title" do
      expect(full_title("foo")).to match(/foo/)
    end

    it "should include the base title" do
      expect(full_title("foo")).to match(/^Welcome to Tutorial/)
    end

    it "should not have the | separator for home page" do
      expect(full_title("")).not_to match(/\|/)
    end
  end
end
