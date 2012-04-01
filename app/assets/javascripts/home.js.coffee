# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    rearrange()

rearrange = () ->
    console.log('rearranging')
    $('.tile').wookmark
        container: $('#content')
        autoResize: true
        offset: 12