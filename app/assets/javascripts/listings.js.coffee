# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

rearrange = ->
    console.log("rearrange...")
    $('.single-tile').wookmark
        container: $('#single-tiles')
        autoResize: true
        offset: 10

    api = $('#thumbnail-column').data('jsp');
    api.reinitialise()



$ ->

    $('#thumbnail-column').height( $(window).height() - $('#thumbnail-column').offset().top - 20 )

    $('#thumbnail-column').jScrollPane
        verticalDragMaxHeight: 30

    rearrange()
    window.every 500, rearrange

    $('.single-tile').click ->
        $('.single-tile').removeClass('active')
        $(this).addClass('active')
        $('#main-photo').attr('src', $(this).children(":first").attr('src'))





