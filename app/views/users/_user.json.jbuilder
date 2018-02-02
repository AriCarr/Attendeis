json.extract! user, :id, :uid, :name, :created_at, :updated_at
json.url user_url(user, format: :json)
