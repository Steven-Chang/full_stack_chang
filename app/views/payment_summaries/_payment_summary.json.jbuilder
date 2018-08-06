json.extract! payment_summary, :id, :created_at, :updated_at
json.url payment_summary_url(payment_summary, format: :json)
