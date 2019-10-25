class Review < ActiveRecord::Base
    belongs_to :school
    belongs_to :course
    belongs_to :user

    def self.get_ten_highest_reviews
        reviews = self.order(rating: :desc).limit(10)
        reviews.map {|review| "--------------------------------------------
Review ##{review.id}. Rated #{review.rating}/5 by #{review.user.username}. Course: #{review.course.topic}. School: #{review.school.name}. 
        #{review.content}"}
    end

    def self.get_ten_lowest_reviews 
        reviews = self.order(rating: :asc).limit(10)
        reviews.map {|review| "--------------------------------------------
Review ##{review.id}. Rated #{review.rating}/5 by #{review.user.username}. Course: #{review.course.topic}. School: #{review.school.name}. 
        #{review.content}"}
    end

    def self.get_reviews_rated_4_and_5
        reviews = self.where("rating > ?", 3)
        reviews.map {|review| "--------------------------------------------
Review ##{review.id}. Rated #{review.rating}/5 by #{review.user.username}. Course: #{review.course.topic}. School: #{review.school.name}. 
        #{review.content}"}
    end

    def self.find_by_keyword(keyword)
        reviews = self.all.select {|review| review.content.include?(keyword)}
        reviews.map {|review| "--------------------------------------------
Review ##{review.id}. Rated #{review.rating}/5 by #{review.user.username}. Course: #{review.course.topic}. School: #{review.school.name}. 
        #{review.content}"}
    end
    
    def self.find_review_by_id(rev_id)
        self.find_by(id: rev_id)
    end

    def self.first_review_id
        self.first.id
    end

    def self.last_review_id
        self.last.id
    end

end