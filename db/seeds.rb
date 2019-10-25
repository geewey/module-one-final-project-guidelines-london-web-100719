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
