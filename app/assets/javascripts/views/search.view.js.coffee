class SearchView extends Backbone.View

    events:
        "submit #advanced-form": "search"
        "blur :input": "updatevalue"

    initialize: ->
        window.allowReload = true
        @model.set('page', 1)
        @bindScroll()

    render: ->
        template = _.template( $('#search_template').html() )
        @$el.append(template)
        @

    dropdown: ->
        $('.dropdown-toggle').dropdown()

        # Fix input element click problem
        $('.dropdown input, .dropdown label').click (e) ->
            e.stopPropagation()

        @

    autocomplete: ->
        #Town autocomplete
        $(".autocomplete").typeahead (
    
            source: (typeahead, query) ->
                $.ajax(
                    url: "/towns.json?q=#{query}"
                    success: (data) ->
                        typeahead.process(data)
                )
    
            property: "town_and_state"
    
            onselect: (obj) =>
                @model.set('mintown', obj.num)
                @model.set('maxtown', obj.num)
                @search(null, false)
    
        )

        @

    search: (e, add) ->
        console.log(add)
        if add
            window.listingsView.$el.trigger("add", @model)
        else
            @model.set('page', 1)
            window.listingsView.$el.trigger("search", @model)

        return false

    updatevalue: (e) ->
        @model.set($(e.target).attr('name'), $(e.target).val())

    bindScroll: ->
        $(window).scroll =>
            return if !window.allowReload
            if ( $(window).scrollTop() + $(window).height() > $(document).height() - 500)
                @model.set('page', @model.get('page') + 1)
                window.allowReload = false
                after 5000, -> window.allowReload = true
                @search(null, true)

@.SearchView = SearchView