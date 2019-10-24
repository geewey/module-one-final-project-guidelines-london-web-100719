class Cli

    # RUNS APP: welcomes user, prompts user to log in, displays the main menu, receives user input
    def run
        input = greet
        login(input)
        choice = menu
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

    # locates user by username within database, or new user will be created
    def login(username)
        @user = User.find_or_create_by_username(username)
    end

    # prompts user to submit a username, receives user input
    def greet
        puts "Hello, what is your username?"
        gets.chomp
    end

    # displays main menu, prompts user to select features: read, submit, manage, exit
    def menu
        puts "Please select from the following:"
        puts "- read : browse all reviews"
        puts "- submit: submit a review"
        puts "- manage : update or delete your reviews"
        puts "- exit : end your session"
        gets.chomp
    end

    # displays exit message
    def exit
        puts "Thank you, goodbye!"
    end

    # displays continue message, receives user input
    def continue_prompt
        puts "=================================="
        puts "Would you like to continue (Y/N)?"
        gets.chomp.downcase
    end

    # RUNS READ FEATURE: displays read menu, prompts user for input, receives user input
    def run_read_reviews
        read_choice = read_menu
        if read_choice == "exit"
            # continues to #exit method on run_main_menu switch
        elsif read_choice == "school"
            view_by_school
        elsif read_choice == "rating"
            view_by_rating
        elsif read_choice == "keyword"
            search_by_keyword
        end

        continue_choice = continue_prompt
        if continue_choice == "y"
            run_read_reviews
        # elsif continue_choice == "n"
        #     # continues to #exit method on run_main_menu switch
        end
    end

    # displays read menu, prompts user to select read features: by school, by rating, by keyword
    def read_menu
        puts "Please select a viewing method:"
        puts "- school : view by school"
        puts "- rating : view by rating"
        puts "- keyword : search by keyword"
        puts "- exit : return to main menu"
        gets.chomp
    end

    # prompts user to select school, displays all reviews by school
    def view_by_school
        puts "Pick a school - Flatiron School, General Assembly, or Makers Academy:"
        school_name = gets.chomp
        puts School.find_reviews_by_school(school_name)
    end

    # displays ratings menu, prompts user to select filter, displays reviews by ratings by filter
    def view_by_rating
        puts "Pick a filter:"
        puts "- highest : view from highest to lowest rating"
        puts "- lowest : view from lowest to highest rating"
        puts "- top : show reviews with ratings 4 and 5"
        filter = gets.chomp

        case filter
        when "highest"
            puts Review.get_highest_reviews
        when "lowest"
            puts Review.get_lowest_reviews
        when "top"
            puts Review.get_top_reviews
        end
    end

    # prompts user to input keyword, displays all reviews that contain keyword
    def search_by_keyword
        puts "Input keyword to search:"
        keyword = gets.chomp
        puts Review.find_by_keyword(keyword)
    end

    # RUNS SUBMIT FEATURE: prompts user for school, course, rating, and content, receives user input, creates new review
    def submit_review
        puts "Pick a school - Flatiron School, General Assembly, or Makers Academy:"
        school_name = gets.chomp
        school = School.find_by(name: school_name)

        puts "Pick a course - Cybersecurity, Data Science, User Experience Design, Software Engineering:"
        course_topic = gets.chomp
        course = Course.find_by(topic: course_topic)

        puts "Enter your rating - 1-5 (5 being highest):"
        rating = gets.chomp.to_i

        puts "Enter your review:"
        content = gets.chomp
        
        review = Review.new(user: @user, school: school, course: course, rating: rating, content: content)
        review.save
        puts "Your review has been submitted. Thank you!"
    end

    # RUNS MANAGE FEATURE: displays manage menu, prompts user for input, receives user input
    def run_manage_reviews
        manage_choice = manage_menu
        if manage_choice == "exit"
        elsif manage_choice == "update"
            update_review
        elsif manage_choice == "delete"
            delete_review
        end

        continue_choice = continue_prompt
        if continue_choice == "y"
            run_manage_reviews
        # elsif continue_choice == "n"
        end
    end

    # displays manage menu, prompts user to select manage features: update, delete
    def manage_menu
        puts "Please select an option from below:"
        puts "- update : update the content of a review"
        puts "- delete : delete a review"
        puts "- exit : return to user menu"
        gets.chomp
    end

    # displays update menu, displays user's own reviews, prompts user to select by review ID, updates selected review's content
    def update_review
        puts "Your current reviews are listed below:"
        @user.display_user_reviews

        puts "Enter the number of the review you would like to change:"
        id_input = gets.chomp

        puts "Now type your new review:"
        new_content = gets.chomp

        review = Review.find_review_by_id(id_input)
        @user.update_review_content(review, new_content)
        @user.reload
        puts "Your review has been submitted. Thank you!"
    end

    # displays update menu, displays user's own reviews, prompts user to select by review ID, deletes selected review
    def delete_review
        puts "Your current reviews are listed below:"
        @user.display_user_reviews

        puts "Enter the number of the review you would like to delete:"
        id_input = gets.chomp

        review = Review.find_review_by_id(id_input)
        @user.delete_review(review)
        @user.reload
        puts "Your review has been deleted. Thank you!"
    end

end