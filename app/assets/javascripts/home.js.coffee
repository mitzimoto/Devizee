# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

after = (ms, cb) -> setTimeout cb, ms
every = (ms, cb) -> setInterval cb, ms

$ ->
    every 500, rearrange

rearrange = () ->
    console.log("rearranging")
    $('.tile').wookmark
        container: $('#tiles')
        autoResize: true
        offset: 12