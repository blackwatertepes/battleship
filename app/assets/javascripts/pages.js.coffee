# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  cell_color = $('.game .cell').css('background')

  $('.game .cell').bind 'mouseover', (e) ->
    $(this).css('background', '#efe')

  $('.game .cell').bind 'mouseout', (e) ->
    $(this).css('background', cell_color)

  # $('#start_btn').bind 'click', (e) ->
  #   e.preventDefault()
  #   name = $('.panel h2').text()
  #   email = $('.panel h4').text()

  #   request = $.ajax '/proxy',
  #     type: 'POST'
  #     dataType: 'jsonp'
  #     data: { name: name, email: email }
  #     error: (xhr, status, error) ->
  #       console.log(xhr, status, error)
  #     done: (data, status, xhr) ->
  #       console.log(data, status, xhr)
