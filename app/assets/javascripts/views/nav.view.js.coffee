class NavView extends Backbone.View
    tagName: 'div'

    initialize: ->
        @$el.addClass('nav-collapse')
        @$el.attr('id', 'nav-container')

        @searchView = new SearchView({model: new Search()})
        @searchView.on('error', @doerror)
    render: ->
        @$el.append( @searchView.render().$el )
        @


@.NavView = NavView