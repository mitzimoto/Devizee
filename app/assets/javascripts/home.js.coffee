# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

after = (ms, cb) -> setTimeout cb, ms
every = (ms, cb) -> setInterval cb, ms

$ ->
    every 500, rearrange
    $('.dropdown-toggle').dropdown()

    # Fix input element click problem
    $('.dropdown input, .dropdown label').click (e) ->
      e.stopPropagation()

    $('#advanced-save').click window.search

    #Town autocomplete
    $('.autocomplete').typeahead (

        source: (typeahead, query) ->
            $.ajax(
                url: "/towns.json?q=#{query}"
                success: (data) ->
                    typeahead.process(data)
            )

        property: "town_and_state"

        onselect: (obj) ->
            $('input[name=mintown]').val(obj.num)
            $('input[name=maxtown]').val(obj.num)
            window.search()

    )

rearrange = () ->
    console.log("rearranging")
    $('.tile').wookmark
        container: $('#tiles')
        autoResize: true
        offset: 12

window.createTile = (listing) ->

    tileHtml = """
                    <div class="tile">
                        <div class="padded">
                            <img src="#{window.getPhotoUrl(listing.list_no, 0)}" alt="#{listing.street_no_titleized} #{listing.street_name_titleized}, #{listing.town.state}"/>
                            <div class="tags">
                                <span class="price badge badge-success">#{listing.list_price_currency}</span>
                                <span class="address"><strong title='#{listing.street_no_titleized} #{listing.street_name_titleized}'>#{listing.address_truncated}</strong></span>
                                <span class="location">#{listing.town.long}, #{listing.town.state} (2 miles)</span>
                            </div>
                        </div>
                        <div class="gray-area">
                            <div class="gray-section-wrapper clearfix">
                                <div class="gray-section">
                                    #{listing.no_bedrooms} Beds
                                </div>
                                <div class="gray-section gray-section-middle">
                                    #{listing.no_full_baths + listing.no_half_baths} Baths
                                </div>
                                <div class="gray-section gray-section-right">
                                    #{listing.square_feet_delimited} sqft
                                </div>
                            </div>
                        </div>
                    </div> <!-- .tile -->
    """

    $("#tiles").append(tileHtml)
