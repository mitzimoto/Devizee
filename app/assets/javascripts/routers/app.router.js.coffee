class AppRouter extends Backbone.Router

    routes:
        '' : 'index'
        '?*parameters' : 'index'
        'page/:page' : 'gotopage'
        'listings/:id/:address' : 'listings'

    initialize: ->
        console.log('Initializing router')
        window.page = 1
        window.nav = new NavView()
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

        console.log(view)
        this.currentView.close() if this.currentView

        this.currentView = view
        this.currentView.render()

    gotopage: (page=1) ->
        window.listingsView.doscroll = true
        window.page = page
        @showView(window.listingsView)

#Export to the global namespace
@.AppRouter = AppRouter