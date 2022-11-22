json.extract! car, :id, :model, :brand, :license, :color, :img_url, :doors, :seats, :state, :engine, :fuel, :position_id, :created_at, :updated_at
json.url car_url(car, format: :json)
