json.extract! flat, :id, :size, :price, :rooms, :description, :created_at, :updated_at
json.url flat_url(flat, format: :json)
