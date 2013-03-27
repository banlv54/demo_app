namespace :db do
	desc "Fill database with same data"
	task populate: :environment do
		admin = User.create!(name: "Example",
			email: "exam@rails.org",
			password: "foobar",
			password_confirmation: "foobar")
		admin.toggle!(:admin)
		
		99.times do |n|
			name = Faker::Name.name
			email = "exam-#{n+1}@rail.org"
			password = "password"
			User.create!(name: name,
				email: email,
				password: password,
				password_confirmation: password)
		end
	end
end