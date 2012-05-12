class ListingView extends Backbone.View

    el: '#main-listing'
    tc: '#thumbnail-column'
    download_status: 'noop'
    reload_max: 5
    reload_tries: 0

    events: 
        'click .single-tile'        : 'loadImage'
        'slid #the-carousel'        : 'slid'
        'mouseover #the-carousel'   : 'showCarouselControl'
        'mouseleave  #the-carousel' : 'hideCarouselControl'
        'mouseover .jspContainer'   : 'showScrollBar'
        'mouseleave .jspContainer'  : 'hideScrollBar'

    initialize: ->
        window.allowReload = false
        console.log("initializing single listing #{@options.listno}")
        @totalThumbs = $('.carousel-inner .item').length
        @loadedThumbs = 0

        $.getJSON "/listings/download/#{@options.listno}.json", (response) =>
            switch response.status
                when 'error' then console.log('Failed to download images')
                when 'success' then @reload_every = window.every 1000, @reloadImages
                when 'noop' then console.log('Images previously downloaded. noop')

    render: ->
        $(@tc).height( $(window).height() - $(@tc).offset().top - 20 )

        $(@tc).jScrollPane
            verticalDragMaxHeight: 30

        #Send a request to download all the photos for this listing
        $('.carousel-inner .item').onImagesLoad
            each: => @updateProgressBar()
            all: => @closeProgressBar()
            errors: => @updateProgressBar()

        $('#the-carousel').carousel()
        $('.carousel-control').hide()

        $('.single-tile').css('visibility', 'hidden')

        @monitor = window.every 500, @rearrange

    rearrange: =>
        $('.single-tile').wookmark
            container: $('#single-tiles')
            autoResize: true
            offset: 10
    
        $(@tc).data('jsp').reinitialise()

    loadImage: (e) =>
        $('.single-tile').removeClass('active')
        $(e.currentTarget).addClass('active')
        index = $(e.currentTarget).attr('data-photo-id')
        $('#the-carousel').carousel(parseInt index)

    slid: (e) ->
        currentSlide = $('#the-carousel .active').attr('data-photo-id')
        $('.single-tile').removeClass('active')
        $("div[data-photo-id=#{currentSlide}]").addClass('active')

    reloadImages: =>
        $('.carousel-inner .item img').each ->
            console.log("reloading carousel image")
            origsrc = @.src
            @.src = origsrc + "#e" + Math.random()

        $('.single-tile img').each ->
            console.log("reloading single tile image")
            origsrc = @.src
            @.src = origsrc + "#e" + Math.random()

        @reload_tries++
        console.log( @reload_tries )
        window.stop @reload_every unless @reload_tries < @reload_max

        return

    updateProgressBar: ->
        @loadedThumbs++
        percent = (@loadedThumbs / @totalThumbs)  * 100
        $('.bar').width( "#{percent}%")

    closeProgressBar: ->
        $('.progress').hide()
        $('.single-tile').css('visibility', 'visible')

    showCarouselControl: ->
        $('.carousel-control').fadeIn()

    hideCarouselControl: ->
        $('.carousel-control').fadeOut()

    showScrollBar: ->
        $('.jspVerticalBar').fadeIn().css('visibility', 'visible').css('display', '')

    hideScrollBar: ->
        $('.jspVerticalBar').fadeOut()

    close: ->
        window.stop @monitor
        @remove()
        @unbind()
        
@.ListingView = ListingView