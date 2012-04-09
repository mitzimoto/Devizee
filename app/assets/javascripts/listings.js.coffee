# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.search = ->
    console.log()
    criteria =
        beds: $("select[name=adv-beds]").val()
        baths: $("select[name=adv-baths]").val()
        minprice: $("input[name=adv-minprice]").val()
        maxprice: $("input[name=adv-maxprice]").val()
        minsqft: $("input[name=adv-minsqft]").val()
        maxsqft: $("input[name=adv-maxsqft]").val()
        mintown: $("input[name=mintown]").val()
        maxtown: $("input[name=maxtown]").val()


    $.getJSON '/listings/search/1.json', criteria, processResults

processResults = (data) ->
    $("#tiles").empty()

    window.createTile listing for listing in data

window.getPhotoUrl = (listNo, photo) ->
    "assets/mls/photo/#{listNo.substring(0,2)}/#{listNo.substring(2,5)}/#{listNo.substring(5,8)}_#{photo}.jpg"