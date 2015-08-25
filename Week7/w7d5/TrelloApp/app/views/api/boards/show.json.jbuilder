json.extract! @board, :id, :title

json.lists do
  json.array! @board.lists do |list|
    json.extract! list, :id, :title, :ord
    json.cards do
      json.array! list.cards do |card|
        json.extract! card, :id, :title, :ord, :description
      end
    end
  end
end
