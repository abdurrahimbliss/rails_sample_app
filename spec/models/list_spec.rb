require 'spec_helper'

describe List do

  let(:user) { FactoryGirl.create(:user) }

  before { @list = user.lists.build(name: "My list") }

  subject { @list }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:personal) }
  it { should respond_to(:user) }

  it { should be_valid }

  describe "validations" do

    describe "name is required" do
      before { @list.name = ' ' }
      it { should_not be_valid }
    end

    describe "description should not be too long" do
      before { @list.description = 'a' * 101 }
      it { should_not be_valid }
    end

    describe "should have the user_id set" do
      before { @list.user_id = nil }
      it { should_not be_valid }
    end
  end
end
