module CoursesHelper

    def get_button_state(course)
        # byebug
        "Click here to #{course.open ? "STOP" : "START"} taking attendance!"
    end

end
