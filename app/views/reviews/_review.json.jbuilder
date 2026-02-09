json.extract! review, :id, :referrable_id, :referrable_type, :field, :url, :message, :created_at, :updated_at
json.url review_url(review, format: :json)
