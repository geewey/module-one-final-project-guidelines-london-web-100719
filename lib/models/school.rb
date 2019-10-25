class School < ActiveRecord::Base
    has_many :reviews
    has_many :courses, through: :reviews
    has_many :users, through: :reviews

    def self.find_reviews_by_school(school_name)
        school = self.find_by(name: school_name)
        school.reviews.map {|review| "--------------------------------------------
Review ##{review.id}. Rated #{review.rating}/5 by #{review.user.username}. Course: #{review.course.topic}. School: #{review.school.name}. 
        #{review.content}"}
    end

    def self.find_or_create(name)
        self.find_or_create_by(name: name)
    end

end