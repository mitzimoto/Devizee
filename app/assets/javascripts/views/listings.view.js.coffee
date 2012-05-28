class ListingsView extends Backbone.View

    perpage: 30

    initialize: ->
        console.log("Initializing ListingsView")
        $('.navbar').after( _.template( $('#tiles_template').html() ) )
        @setElement( $('#tiles') )

    events:
        "search"        : "search"
        "add"           : "add"
        "reset"         : "reset"

    render: () ->
        @appendTile listing for listing in @model.models
        @rearrange()
        window.allowReload = true

    reset: (e) ->
        @$el.empty()

    appendTile: (listing) ->
        template = _.template($('#tile_template').html())
        @$el.append(template(listing.attributes))

    scrollto: (page=window.page) =>
        offset = ((page - 1) * @perpage)
        if offset > 0
            scrollTo = $('.tile')[offset - 1]
            console.log("scrolling to #{$(scrollTo).offset().top}")
            $('body,html').animate 
                scrollTop: ($(scrollTo).offset().top - 50)

        return @

    rearrange: ->
        $('.tile').wookmark
            container: @$el
            autoResize: true
            offset: 12

        window.after 500, @scrollto if @doscroll
        @doscroll = false


    search: (e, criteria, add) ->
        window.TheRouter.navigate('') unless add
        @model.fetch    
            data: criteria.attributes
            success: (collection, response) =>
                @reset() unless add
                @render()
                window.scrollTo(0,0) unless add

        $('.dropdown').removeClass('open')

    add: (e, criteria) ->
        @search(e, criteria, true)

    close: ->
        @remove()
        @unbind()

#Export to the global namespace
@.ListingsView = ListingsView

#    $(window).scroll ->
#        return if !window.allowReload
#        if ( $(window).scrollTop() + $(window).height() > $(document).height() - 500)
#            page = parseInt($('input[name=page]').val()) + 1 
#            $('input[name=page]').val(page)
#            console.log("Getting more results [#{page}]")
#            window.allowReload = false
#            after 5000, -> window.allowReload = true
#            window.doSearch window.client
