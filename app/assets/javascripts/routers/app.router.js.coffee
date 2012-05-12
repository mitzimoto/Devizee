class AppRouter extends Backbone.Router

    routes:
        '' : 'index'
        'listings/:id/:address' : 'listings'

    initialize: ->
        console.log('Initializing router')
        nav = new NavView()
        $('.navbar .container').append( nav.render().$el )

        nav.searchView.autocomplete()
        nav.searchView.dropdown()

        listings        = new Listings(window.initialListings)
        
        #global listings view
        window.listingsView    = new ListingsView({model:listings})

    index: ->
        @showView(window.listingsView)

    listings: (id) ->
        listing = new ListingView({listno: id})
        @showView(listing)
        #listing.attach()

    showView: (view) ->

        this.currentView.close() if this.currentView

        this.currentView = view
        this.currentView.render()

#Export to the global namespace
@.AppRouter = AppRouter