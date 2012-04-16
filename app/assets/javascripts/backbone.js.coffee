class Listing extends Backbone.Model
    initialize: ->
        console.log "Initializing Listing Model"


class Listings extends Backbone.Collection
    model: Listing
    url: '/listings/search.json'

class ListingsView extends Backbone.View

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

class AppRouter extends Backbone.Router

    routes:
        '' : 'index'

    index: ->
        listings = new Listings()
        listings.reset(window.initialListings)
        listingsView = new ListingsView({model:listings})
        listingsView.render()


$ ->
    TheRouter = new AppRouter
    Backbone.history.start();