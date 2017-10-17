$(document).on 'turbolinks:load', ->
	$(document).on('nested:fieldAdded', (event) ->
		field = event.field;
		number = $('.nested-team-players .fields').length
		field.css("padding-top", "15px")
		field.find(".label-player-session").text("Player " + number)
		$(".nested-team-players .add_nested_fields").hide()
	)

	$(document).on('nested:fieldRemoved', (event) ->
		field = event.field;
		number = $('.nested-team-players .fields').length
		field.css("padding-top", "15px")
		$(".nested-team-players .add_nested_fields").show()
	)