class SearchView extends Backbone.View

    events:
        "submit #advanced-form": "search"
        "blur :input" : "updatevalue"
        "click .sort" : "updatesort"

    initialize: ->
        window.allowReload = true
        @model.set('page', window.page)
        @model.set('sort', 'newest')
        @bindScroll()
        @model.bind('error', @doerror);

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

        return false unless @dovalidation()

        if add
            window.listingsView.$el.trigger("add", @model)
        else
            @model.set('page', 1)
            window.listingsView.$el.trigger("search", @model)

        return false

    dovalidation: -> 
        if @model.validate(@model.attributes)
            @model.trigger('error', @model.errorDetail)
            return false

        #Everything's cool. Clear errors
        $('.control-group').removeClass('error')
        $('.control-group').tooltip('disable')

        return true

    updatevalue: (e) ->
        @model.set($(e.target).attr('name'), $(e.target).val(), {silent: true})

    updatesort: (e) ->
        $('#sort-dropdown').html( "Sort By: " + $(e.target).html() + " <b class='caret'></b>")
        @model.set('sort', $(e.target).attr('data-sort'))
        @search(null, false)

    bindScroll: ->
        $(window).scroll =>
            return if !window.allowReload
            if ( $(window).scrollTop() + $(window).height() > $(document).height() - 500)
                @model.set('page', ++window.page )
                page = @model.get('page')
                window.allowReload = false
                after 5000, -> window.allowReload = true
                @search(null, true)
                window.TheRouter.navigate("page/#{page}")

    doerror: (error) ->
        console.log(error)
        console.log($("[data-control-group=#{error.group}]"))
        errorGroup = $("[data-control-group=#{error.group}]")
        errorGroup.addClass('error')
        errorGroup.tooltip
            title: error.error
            zIndex: 2000
            placement: 'bottom'
        errorGroup.tooltip('enable')
        errorGroup.tooltip('show') 

@.SearchView = SearchView