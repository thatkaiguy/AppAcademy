json.array! @boards do |board|
  json.extract! board, :id, :title
end
