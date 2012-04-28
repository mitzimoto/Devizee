# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


window.after = (ms, cb) -> setTimeout cb, ms
window.every = (ms, cb) -> setInterval cb, ms
window.stop  = (cb) -> clearInterval cb

unless window.console
    window.console = 
        log: (obj) -> 
            return


$ ->
    window.TheRouter = new AppRouter
    Backbone.history.start({pushState: true});
