# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


window.after = (ms, cb) -> setTimeout cb, ms
window.every = (ms, cb) -> setInterval cb, ms

unless window.console
    window.console = 
        log: (obj) -> 
            return


$ ->
    TheRouter = new AppRouter
    Backbone.history.start({pushState: true});

