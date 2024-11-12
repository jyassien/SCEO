json.extract! user, :id, :username, :email, :password_digest, :user_type, :college_name, :created_at, :updated_at
json.url user_url(user, format: :json)
