json.array!(@movies) do |movie|
  json.extract! movie, :name, :description
  json.url movie_url(movie, format: :json)
end
