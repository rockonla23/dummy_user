class UserImporter
  def self.import
     20.times do |x|
       User.create(
         username: Faker::Name.name,
        email: Faker::Internet.email,
        password: "111111"
        )
    end
  end
end
UserImporter.import