class Search extends Backbone.Model

    initialize: ->

    validate: (attrs) ->
        if (Number) attrs.minprice > (Number) attrs.maxprice
            @.errorDetail = {error: "Minimum price cannot be more than Maximum price", group: 'price' }
            return @

        if (Number) attrs.minsqft > (Number) attrs.maxsqft
            @.errorDetail = {error: "Minimum sqft cannot be more than Maximum sqft", group: 'squarefeet'}
            return @

@.Search = Search