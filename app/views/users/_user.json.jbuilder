json.extract! user, :id, :email, :crypted_password, :salt, :rol, :name, :lastName, :document, :state, :license_url, :created_at, :updated_at
json.url user_url(user, format: :json)
