require_relative '../config/environment.rb'

User.destroy_all
School.destroy_all
Course.destroy_all
Review.destroy_all


table = CSV.parse(File.read('./db/review_data.csv'), headers: true)

table.each do |row|
    school = School.find_or_create_by(name: row[0])
    course = Course.find_or_create_by(topic: row[1])
    user = User.find_or_create_by(username: row[2])
    rating = row[3].to_i
    content = row[4]
    
    Review.create(school: school, course: course, user: user, rating: rating, content: content)
end

# 10.times do |count|
#     User.create(username: "username#{count + 1}")
# end

# schools = ["Flatiron School","Makers Academy","General Assembly"]
# School.create(name: schools[0])
# School.create(name: schools[1])
# School.create(name: schools[2])

# courses =["Software Engineering","Data Science", "Cybersecurity", "User Experience Design"]
# Course.create(topic: courses[0])
# Course.create(topic: courses[1])
# Course.create(topic: courses[2])
# Course.create(topic: courses[3])

# 100.times do |count|
#     Review.create(school: School.all.sample, course: Course.all.sample, user: User.all.sample, rating: rand(1..5), content: Faker::Hacker.say_something_smart)
# end


