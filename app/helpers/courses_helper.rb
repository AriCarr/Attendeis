module CoursesHelper

    def get_button_state(course)
        # byebug
        "Click here to #{course.started ? "STOP" : "START"} taking attendance!"
    end

end
