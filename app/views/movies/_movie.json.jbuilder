json.extract! movie, :id, :title, :description, :rating, :runtime, :released, :url, :checked_out_to_id, :created_at, :updated_at
json.url movie_url(movie, format: :json)
