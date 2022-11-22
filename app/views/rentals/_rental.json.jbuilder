json.extract! rental, :id, :price, :expires, :user_id, :car_id, :created_at, :updated_at
json.url rental_url(rental, format: :json)
