$(document).on 'turbolinks:load', ->
	$(document).on('nested:fieldAdded', (event) ->
		field = event.field;
		number = $('.nested-games .fields').length
		field.css("padding-top", "15px")
		field.find(".label-game-session").text("Game " + number)
		if(number > 2)
			$(".nested-games .add_nested_fields").hide()
	)