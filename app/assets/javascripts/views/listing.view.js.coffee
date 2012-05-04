class ListingView extends Backbone.View

    el: '#main-listing'
    tc: '#thumbnail-column'

    events: 
        'click .single-tile'        : 'loadImage'
        'slid #the-carousel'        : 'slid'
        'mouseover #the-carousel'   : 'showCarouselControl'
        'mouseleave  #the-carousel' : 'hideCarouselControl'
        'mouseover .jspContainer'   : 'showScrollBar'
        'mouseleave .jspContainer'  : 'hideScrollBar'

    initialize: ->
        window.allowReload = false
        console.log("initializing single listing view")
        @totalThumbs = $('.carousel-inner .item').length
        @loadedThumbs = 0

    render: ->
        $(@tc).height( $(window).height() - $(@tc).offset().top - 20 )

        $(@tc).jScrollPane
            verticalDragMaxHeight: 30

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

    updateProgressBar: ->
        @loadedThumbs++
        percent = (@loadedThumbs / @totalThumbs)  * 100
        console.log("#{percent}%")
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