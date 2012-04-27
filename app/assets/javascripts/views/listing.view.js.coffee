class ListingView extends Backbone.View

    el: '#main-listing'
    tc: '#thumbnail-column'

    events: 
        '.single-tile click' : 'loadImage'

    initialize: ->
        console.log("initializing single listing view")

    render: ->
        console.log("render")

    attach: ->
        $(@tc).height( $(window).height() - $(@tc).offset().top - 20 )

        $(@tc).jScrollPane
            verticalDragMaxHeight: 30

        window.every 500, @rearrange


    rearrange: =>
        $('.single-tile').wookmark
            container: $('#single-tiles')
            autoResize: true
            offset: 10
    
        $(@tc).data('jsp').reinitialise()

    loadImage: (e) ->
        $('.single-tile').removeClass('active')
        $(e.target).addClass('active')
        $('#main-photo').attr('src', $(e.target).children(":first").attr('src'))


@.ListingView = ListingView