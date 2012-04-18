class AppRouter extends Backbone.Router

    routes:
        '' : 'index'

    index: ->

        nav = new NavView()
        $('.navbar .container').append( nav.render().$el )

        nav.searchView.autocomplete()
        nav.searchView.dropdown()

        listings        = new Listings(window.initialListings)
        
        #global listings view
        window.listingsView    = new ListingsView({model:listings})
        window.listingsView.render()


#Export to the global namespace
@.AppRouter = AppRouter