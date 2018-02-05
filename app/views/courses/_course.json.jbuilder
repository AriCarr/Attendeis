json.extract! course, :id, :name, :admin_uid, :created_at, :updated_at
json.url course_url(course, format: :json)
