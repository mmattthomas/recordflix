json.extract! track, :id, :title, :description, :likes, :comments, :url, :posted_by_id, :team_id, :created_at, :updated_at
json.url track_url(track, format: :json)
