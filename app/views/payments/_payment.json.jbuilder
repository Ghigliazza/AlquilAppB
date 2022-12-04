json.extract! payment, :id, :price, :expires, :rent_hs, :cancel, :rental_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
