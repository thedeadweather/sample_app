require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }  

    describe "invalid info" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      # created at support/utilitirs.rb
      it { should have_error_message('Invalid') }
    end

    describe "valid info" do
      let(:user) { FactoryGirl.create(:user) }
      # created at support/utilities.rb
      before { valid_signin(user) }

      it { should have_title(user.name) }
      it { should have_link('Profile',   href: user_path(user)) }
      it { should have_link('Sign out',  href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end
end


