class SearchView extends Backbone.View

    tagName: 'form'

    initialize: ->
        @$el.addClass('navbar-search')
        @$el.addClass('pull-left')
        @$el.attr('id', '#search-form')

    render: ->
        template = _.template( $('#search_template').html() )
        @$el.append(template)
        @

    autocomplete: ->
        #Town autocomplete
        console.log("autocomplete")
        $(".autocomplete").typeahead (
    
            source: (typeahead, query) ->
                $.ajax(
                    url: "/towns.json?q=#{query}"
                    success: (data) ->
                        typeahead.process(data)
                )
    
            property: "town_and_state"
    
            onselect: (obj) ->
                $('input[name=mintown]').val(obj.num)
                $('input[name=maxtown]').val(obj.num)
                window.search()
    
        )

        @


#Export to the global namespace
@.SearchView = SearchView