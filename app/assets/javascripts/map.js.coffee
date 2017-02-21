# Bind a tooltip to each marker layer
# feature - A GeoJSON Point layer
# layer - A Leaflet map layer
bindTooltip = (feature, layer) ->
  prop = feature.properties
  address = prop.address1
  address += prop.address2 if prop.address2
  html = "<h5><a href='#{prop.url}'>#{prop.name}</a></h5>
          <address>#{address} #{prop.city}, #{prop.state} #{prop.zip}</address>"

  layer.bindPopup(html)

# Render a US-centered map to the screen
# el - HTMLElement map container
# data - GeoJSON of point data
renderMap = (el, data) ->
  map = L.map(el.id).setView([37.0902, -95.7129], 4)
  L.tileLayer('//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', { maxZoom: 18 })
    .addTo(map)

  L.geoJson(data, onEachFeature: bindTooltip)
    .addTo(map)

# Fetch GeoJSON map data at `data-url` attribute
# Calls renderMap on result data
fetchMap = (index, el) ->
  $el = $(el)
  url = $el.attr 'data-url'
  $.getJSON(url)
  .done((data) -> renderMap(el, data))

$ -> $('.js-map').each(fetchMap)
