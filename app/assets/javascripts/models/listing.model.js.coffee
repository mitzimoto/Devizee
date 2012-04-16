class Listing extends Backbone.Model
    
    initialize: ->
        console.log "Initializing Listing Model"


class Listings extends Backbone.Collection
    model: Listing
    url: '/listings/search.json'

    doSearch: ->
        console.log("Searching!")


#Export to the global namespace
@.Listing  = Listing
@.Listings = Listings