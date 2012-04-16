class AppRouter extends Backbone.Router

    routes:
        '' : 'index'

    index: ->

        nav = new NavView()
        $('.navbar .container').append( nav.render().$el )

        nav.searchView.autocomplete()
        nav.advancedView.dropdown()

        listings        = new Listings(window.initialListings)
        listingsView    = new ListingsView({model:listings})
        listingsView.render()


#Export to the global namespace
@.AppRouter = AppRouter