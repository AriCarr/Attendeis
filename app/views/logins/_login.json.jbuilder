json.extract! login, :id, :uid, :name, :created_at, :updated_at
json.url login_url(login, format: :json)
