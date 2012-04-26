class ListingView extends Backbone.View

    tagName: 'div'

    events:
        'hide': 'hide'

    initialize: ->
        console.log("Initializing listing view")
        @$el.addClass 'modal'
        @$el.attr 'id', 'MyModal'

    render: ->
        template = _.template( $('#listing_template').html() )
        @$el.html template 

    hide: ->
        @remove()
        false


@.ListingView = ListingView