class User < ActiveRecord::Base
    has_many :reviews
    has_many :schools, through: :reviews
    has_many :courses, through: :reviews

    def display_user_reviews
        self.reviews.each {|review| puts "Review ##{review.id}. #{review.content}"}
    end

    def self.find_or_create_by_username(username)
        self.find_or_create_by(username: username)
    end

    def update_review_content(review, new_content)
      review.update(content: new_content)
    end

    def delete_review(review)
        review.destroy
    end

end