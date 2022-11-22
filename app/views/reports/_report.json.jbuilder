json.extract! report, :id, :description, :user_id, :car_id, :created_at, :updated_at
json.url report_url(report, format: :json)
