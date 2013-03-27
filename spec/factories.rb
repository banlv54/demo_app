FactoryGirl.define do
	factory :user do
		sequence(:name) { |n| "Pserson #{n}" }
		sequence(:email) { |n| "pserson_#{n}@exam.com" }
		password "foobar"
		password_confirmation "foobar"

		factory :admin do
			admin true
		end
	end
end