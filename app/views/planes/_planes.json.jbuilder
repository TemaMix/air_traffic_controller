
json.planes do
  json.partial! 'planes/plane', collection: planes, as: :plane
end