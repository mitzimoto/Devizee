class AdvancedView extends Backbone.View

    tagName: 'ul'

    initialize: ->
        @$el.addClass('nav')
        @$el.attr('id', '#navlinks')

    render: ->
        template = _.template( $('#navlinks_template').html() )
        @$el.append(template)
        @

    dropdown: ->
        $('.dropdown-toggle').dropdown()

        # Fix input element click problem
        $('.dropdown input, .dropdown label').click (e) ->
            e.stopPropagation()

        @

#Export to the global namespace
@.AdvancedView = AdvancedView