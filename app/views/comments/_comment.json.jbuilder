json.extract! comment, :id, :user_id, :movie_id, :body, :rating, :created_at, :updated_at
json.url comment_url(comment, format: :json)
