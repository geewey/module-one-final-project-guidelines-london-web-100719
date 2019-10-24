class Review < ActiveRecord::Base
    belongs_to :school
    belongs_to :course
    belongs_to :user

    def self.get_highest_reviews
        reviews = self.order(rating: :desc).limit(10)
        reviews.map {|review| review.content}
    end

    def self.get_lowest_reviews 
        reviews = self.order(rating: :asc).limit(10)
        reviews.map {|review| review.content}
    end

    def self.get_top_reviews
        reviews = self.where("rating > ?", 3)
        reviews.map {|review| review.content}
    end

    def self.find_by_keyword(keyword)
        reviews = self.all.select {|review| review.content.include?(keyword)}
        reviews.map {|review| review.content}
    end
    
    def self.find_review_by_id(rev_id)
        self.find_by(id: rev_id)
    end

end