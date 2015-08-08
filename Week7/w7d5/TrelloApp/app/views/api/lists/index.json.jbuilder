json.array! @lists do |list|
  json.extract! list, :id, :title, :ord, :board_id
end
