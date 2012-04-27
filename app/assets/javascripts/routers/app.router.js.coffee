class AppRouter extends Backbone.Router

    routes:
        '' : 'index'
        'listings/:id' : 'listings'

    index: ->
        nav = new NavView()
        $('.navbar .container').append( nav.render().$el )

        nav.searchView.autocomplete()
        nav.searchView.dropdown()

        listings        = new Listings(window.initialListings)
        
        #global listings view
        window.listingsView    = new ListingsView({model:listings})
        window.listingsView.render()

    listings: ->
        listing = new ListingView()
        listing.attach()

#Export to the global namespace
@.AppRouter = AppRouter