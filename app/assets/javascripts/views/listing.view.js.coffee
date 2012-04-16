class ListingsView extends Backbone.View

    @.ListingsView = ListingsView

    el: '#tiles'

    initialize: ->

    render: (e) ->
        @.appendTile listing for listing in @.model.models
        @.rearrange()

    appendTile: (listing) ->
        template = _.template($('#tile_template').html())
        @.$el.append(template(listing.attributes))
        @.rearrange()
        

    rearrange: ->
        console.log("rearrange")
        $('.tile').wookmark
            container: @.$el
            autoResize: true
            offset: 12


#Export to the global namespace
@.ListingsView = ListingsView
