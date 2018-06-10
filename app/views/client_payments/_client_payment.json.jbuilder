json.extract! client_payment, :id, :created_at, :updated_at
json.url client_payment_url(client_payment, format: :json)