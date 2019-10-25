class Cli

    # RUNS APP: welcomes user, prompts user to log in, displays the main menu, receives user input
    def run
        system("clear")
        username = greet
        login(username)
        choice = main_menu
        case choice
        when "read"
            run_read_reviews
        when "submit"
            submit_review
        when "manage"
            run_manage_reviews
        when "exit" 
        end
        exit
    end

    # prompts user to submit a username, receives user input
    def greet
        puts "============================================"
        puts "==== Welcome to Coding Bootcamp Review! ===="
        puts "============================================"
        puts "\n"
        puts "Hello, what is your username?"
        gets.chomp
    end

    # locates user by username within database, or new user will be created
    def login(username)
        @user = User.find_or_create_by_username(username)
    end

    # displays main menu, prompts user to select features: read, submit, manage, exit
    def main_menu
        puts "\n"
        puts "Please select from the following:"
        puts "- read : browse all reviews"
        puts "- submit: submit a review"
        puts "- manage : update or delete your reviews"
        puts "- exit : end your session"
        gets.chomp.downcase
    end

    # displays invalid input message
    def invalid_input
        puts "\n"
        puts "Your input was invalid."
    end

    # displays exit message
    def exit
        puts "\n"
        puts "Thank you, goodbye!"
    end

    # displays continue message, receives user input
    def continue_prompt
        puts "============================================"
        puts "Would you like to continue (Y/N)?"
        gets.chomp.downcase
    end

    # RUNS READ FEATURE: read reviews by school, rating, keyword search; return to main menu
    def run_read_reviews
        read_choice = read_menu
        if read_choice == "school"
            view_by_school
        elsif read_choice == "rating"
            view_by_rating
        elsif read_choice == "keyword"
            search_by_keyword
        elsif read_choice == "main menu"
            run
        end

        continue_choice = continue_prompt
        if continue_choice == "y"
            run_read_reviews
        end
    end

    # displays read menu, prompts user to select read features: by school, by rating, by keyword
    def read_menu
        puts "\n"
        puts "Please select a viewing method:"
        puts "- school : view by school"
        puts "- rating : view by rating"
        puts "- keyword : search by keyword"
        puts "- main menu : return to main menu"
        gets.chomp.downcase
    end
    
    # prompts user to select school, displays all reviews by school
    def view_by_school
        input_school
        puts "\n"
        puts School.find_reviews_by_school(@school_name)
    end

      # prompts user for a school, validates school matches existing list of schools
      def input_school
        puts "\n"
        puts "Pick a school - Flatiron School, General Assembly, or Makers Academy:"
        @school_name = gets.chomp
        if !(@school_name == "Flatiron School" || @school_name == "General Assembly" || @school_name == "Makers Academy")
            invalid_input
            input_school
        else
            @school_name
        end
    end

    # displays ratings menu, prompts user to select filter, displays reviews by ratings by filter
    def view_by_rating
        puts "\n"
        puts "Pick a filter:"
        puts "- highest : show the ten highest rated reviews"
        puts "- lowest : show the ten lowest rated reviews"
        puts "- top : show all reviews with ratings 4 and 5"
        filter = gets.chomp.downcase

        case filter
        when "highest"
            puts "\n"
            puts Review.get_ten_highest_reviews
        when "lowest"
            puts "\n"
            puts Review.get_ten_lowest_reviews
        when "top"
            puts "\n"
            puts Review.get_reviews_rated_4_and_5
        end
    end

    # prompts user to input keyword, displays all reviews that contain keyword
    def search_by_keyword
        puts "\n"
        puts "Input keyword to search:"
        keyword = gets.chomp
        puts "\n"
        keyword_results = Review.find_by_keyword(keyword)
        if keyword_results.length == 0
            puts "No results were found"
        else
            puts keyword_results
        end
    end

    # RUNS SUBMIT FEATURE: creates new review after prompting user for school, course, rating, and content
    def submit_review
        input_school
        school = School.find_by(name: @school_name)
        input_course
        course = Course.find_by(topic: @course_topic)
        input_rating
        rating = @rating
        input_review_content
        content = @content
        # creates and saves new instance of review
        review = Review.new(user: @user, school: school, course: course, rating: rating, content: content)
        review.save
        puts "\n"
        puts "Your review has been submitted. Thank you!"

        continue_choice = continue_prompt
        if continue_choice == "y"
            run_read_reviews
        end
    end

    # prompts user for a course, validates course matches existing list of courses
    def input_course
        puts "\n"
        puts "Pick a course - Cybersecurity, Data Science, User Experience Design, Software Engineering:"
        @course_topic = gets.chomp
        if !(@course_topic == "Cybersecurity" || @course_topic == "Data Science" || @course_topic == "Software Engineering" || @course_topic == "User Experience Design")
            invalid_input
            input_course
        else
            @course_topic
        end
    end

    # prompts user for a rating, validates rating is between 1-5, inclusive
    def input_rating
        puts "\n"
        puts "Enter your rating - 1-5 (5 being highest):"
        @rating = gets.chomp.to_i
        if !(@rating.between?(1, 5))
            invalid_input
            input_rating
        else
            @rating
        end
    end

    # RUNS MANAGE FEATURE: update review, delete review; return to main menu
    def run_manage_reviews
        manage_choice = manage_menu
        if manage_choice == "main menu"
            run
        elsif manage_choice == "update"
            update_review
        elsif manage_choice == "delete"
            delete_review
        end

        continue_choice = continue_prompt
        if continue_choice == "y"
            run_manage_reviews
        end
    end

    # displays manage menu, prompts user to select from manage features: update, delete, main menu
    def manage_menu
        puts "\n"
        puts "Please select an option from below:"
        puts "- update : update the content of a review"
        puts "- delete : delete a review"
        puts "- main menu : return to main menu"
        gets.chomp.downcase
    end

    # displays user's own reviews, prompts user to select and update by review ID, updates selected review's content
    def update_review
        display_user_reviews
        input_review_id
        input_review_content
        review = Review.find_review_by_id(@review_id_input)
        @user.update_review_content(review, @content)
        @user.reload
        puts "\n"
        puts "Your review has been submitted. Thank you!"
    end

    # displays user's own reviews, prompts user to select by review ID, deletes selected review
    def delete_review
        display_user_reviews
        input_review_id
        review = Review.find_review_by_id(@review_id_input)
        @user.delete_review(review)
        @user.reload
        puts "\n"
        puts "Your review has been deleted. Thank you!"
    end

    # display user's reviews
    def display_user_reviews
        puts "\n"
        puts "Your current reviews are listed below:"
        puts @user.display_user_reviews
    end

    # prompts user for a review id, validates the id matches one of user's reviews
    def input_review_id
        puts "\n"
        puts "Enter the number of the review:"
        @review_id_input = gets.chomp.to_i
        if !@user.display_review_ids.include?(@review_id_input)
            invalid_input
            input_review_id
        else
            @review_id_input
        end
    end

    # prompts user for review content, validate user's review length to be at least 1 character
    def input_review_content
        puts "\n"
        puts "Enter your review:"
        @content = gets.chomp
        if @content.length < 1
            invalid_input
            input_review_content
        else
            @content
        end
    end

end