json.extract! card, :id, :number, :expires, :bankName, :user_id, :created_at, :updated_at
json.url card_url(card, format: :json)
