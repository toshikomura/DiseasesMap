# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready(->
  handler = Gmaps.build("Google")
  handler.buildMap
    provider: {}
    internal:
      id: "map"
  , ->
    markers = handler.addMarkers([
      lat: 0
      lng: 0
      picture:
        url: "https://addons.cdn.mozilla.net/img/uploads/addon_icons/13/13028-64.png"
        width: 36
        height: 36

      infowindow: "hello!"
    ])
    handler.bounds.extendWith markers
    handler.fitMapToBounds()


  $("#generateRoute").click ->
    origin = document.getElementById("origin").value
    intermediates = document.getElementById("intermediates").value
    destination = document.getElementById("destination").value
    travel_mode = document.getElementById("travel_mode").value
    direction_color = document.getElementById("direction_color").value
    options = {}

    if intermediates?
        if not _.isEmpty(intermediates)

            waypts = []
            intermediates_points = intermediates.split('#')
            i = 0

            while i < intermediates_points.length
                if intermediates_points[i]?
                    waypts.push
                        location: intermediates_points[i]
                        stopover: true
                i++

            options.waypoints = waypts

    if travel_mode?
        if not _.isEmpty(travel_mode)
            options.travelMode = travel_mode

    if direction_color?
        if not _.isEmpty(direction_color)
            options.polylineOptions = strokeColor: direction_color

    if origin? and destination?
        if not _.isEmpty(origin) and not _.isEmpty(destination)

            handler.addDirection(
                { origin: origin, destination: destination},
                options
            )
            direction_routes = handler.direction_routes
            if direction_routes?
                if direction_routes.length > 0
                    summaryPanel = document.getElementById("directions_panel")
                    summaryPanel.innerHTML = ""

                    i = 0

                    while i < direction_routes.legs.length
                        routeSegment = i + 1
                        summaryPanel.innerHTML += "<b>Route Segment: " + routeSegment + "</b><br>"
                        summaryPanel.innerHTML += direction_routes.legs[i].start_address + " to "
                        summaryPanel.innerHTML += direction_routes.legs[i].end_address + "<br>"
                        summaryPanel.innerHTML += direction_routes.legs[i].distance.text + "<br><br>"
                        i++

        else
            alert "Need to inform origin and destination"
    else
        alert "Need to inform origin and destination"

    return


  $("#clearDirectionsOfMap").click ->
    handler.clearDirections()


  return

)
