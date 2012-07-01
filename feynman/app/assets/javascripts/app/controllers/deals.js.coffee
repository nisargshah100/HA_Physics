class App.DealsIndex extends Spine.Controller
  constructor: ->
    super
    Deal.fetch()
    Deal.bind 'refresh', @render

  render: =>
    $("#deals").html @template()

  template: ->
    @deals = Deal.all()

    @view('deals/index')(@)
