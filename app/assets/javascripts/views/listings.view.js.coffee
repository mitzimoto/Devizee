class ListingsView extends Backbone.View

    el: '#tiles'

    initialize: ->

    events:
        "search"        : "search"
        "add"           : "add"
        "reset"         : "reset"

    render: (e) ->
        @appendTile listing for listing in @model.models
        @rearrange()

    reset: (e) ->
        @$el.empty()

    appendTile: (listing) ->
        template = _.template($('#tile_template').html())
        @$el.append(template(listing.attributes))

    rearrange: ->
        console.log("rearrange")
        $('.tile').wookmark
            container: @.$el
            autoResize: true
            offset: 12

    search: (e, criteria, add) ->
        @model.fetch    
            data: criteria.attributes
            success: (collection, response) =>
                @reset() unless add
                @render()

    add: (e, criteria) ->
        @search(e, criteria, true)

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
