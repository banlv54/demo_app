require 'spec_helper'

describe "User pages" do
	
	subject { page }

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user)}
		before { visit user_path(user)}

		it{ should have_selector('h1', text: user.name)}
		it { should have_selector('title', text: user.name)}

	end
  	
#

	describe "signup" do
		before { visit signup_path }
		let(:submit) { "Create my account"}

		describe "with invalid information" do
			it "should not create a user " do
				expect { click_button submit }.not_to change(User, :count) 
			end
		end

		describe "with valid information" do
	      before do
	        fill_in "Name",         with: "Example User"
	        fill_in "Email",        with: "user@example.com"
	        fill_in "Password",     with: "foobar"
	        fill_in "Confirmation", with: "foobar"
	      end
	      it "should create a user" do
        	expect { click_button submit }.to change(User, :count).by(1)
          end
    	end
	end

	describe "edit" do
		let(:user) {FactoryGirl.create(:user)}
		before { visit edit_user_path(user) }
		describe "page" do
			it { should have_selector('h1', text: "Update your profile")}
			it { should have_selector('title', text: "Edit user")}
			it { should have_link('change', href:'http://gravatar.com/email')}
		end

		describe "with invalid information" do
			before { click_button "Save change"}
			it { should have_content "error"}
		end
		end
  subject { page }

  describe "index" do

    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1',    text: 'All users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end
  end
end