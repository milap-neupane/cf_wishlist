json.array!(@wish_lists) do |wish_list|
  json.extract! wish_list, :id
  json.url wish_list_url(wish_list, format: :json)
end
