class NavView extends Backbone.View
    tagName: 'div'

    initialize: ->
        @$el.addClass('nav-collapse')
        @$el.attr('id', 'nav-container')

        @searchView = new SearchView()
        @advancedView = new AdvancedView()

    render: ->

        @$el.append( @searchView.render().$el )
        @$el.append( @advancedView.render().$el )

        @

@.NavView = NavView