class TopDistricts
  fetch: ->
    $.get '/dashboard/data/districts', (data) =>
      @parse_data(data)
      @render()

  parse_data: (data) ->
    ls = data.livingsocial
    groupon = data.groupon

    @ls = []
    @ls.push({ district: key, revenue: val }) for key, val of ls

    @groupon = []
    @groupon.push({district: key, revenue: val }) for key, val of groupon

  render: ->
    $("#header").html('Top districts');
    @render_table()

  render_table: ->
    source = $("#districts-data-table").html()
    template = Handlebars.compile(source)

    ls_source = template({ data: @ls })
    g_source = template({ data: @groupon })

    $("#container").html("<div style='width: 300px; float: left; margin-right: 10px;'><h3>LivingSocial</h3><hr />#{ls_source}</div><div style='width: 300px; float: left;'><h3>Groupon</h3><hr />#{g_source}</div>")

window.TopDistricts = TopDistricts