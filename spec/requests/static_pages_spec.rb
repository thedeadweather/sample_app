require 'spec_helper'

describe "Static pages" do
#let - rspec function, which create a variable, equaled it's argument 
   # let(:base_title) { "Ruby on Rails Tutorial Sample App" }

   #tell rspec that page is our testing subject 
    subject { page }

  describe "Home page" do
	  #visit root before each test
    before { visit root_path }

    it { should have_content('Sample App') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
  end
  
  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end
  
  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(full_title('About Us')) }
  end
  
  describe "Contact page" do
    before { visit contact_path }
    
    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
end
