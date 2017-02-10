require 'spec_helper'

describe "List pages" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:list) { FactoryGirl.create(:list, user: user) }

  subject { page }

  describe "index page" do
    before do
      sign_in user
      visit user_lists_path(user)
    end

    it { should have_title(full_title(user.name)) }
    it { should have_selector('h3', text: 'Subscribed to') }
    it { should have_content(list.name) }
  end

  describe "show page" do
    before do
      sign_in user
      visit user_list_path(user, list)
    end

    it { should have_title(full_title(list.name)) }
    it { should have_selector('h1', text: list.name) }
    it { should have_link(user.name, href: user_path(user)) }
  end
end
