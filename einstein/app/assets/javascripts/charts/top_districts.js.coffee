class TopDistricts
  fetch: ->
    $.get '/dashboard/data/districts', (data) =>
      @parse_data(data)
      @render()
      @render_graph()

  parse_data: (data) ->
    ls = data.livingsocial
    groupon = data.groupon

    @ls = []
    @ls.push({ district: key, revenue: (val / 100.0).toFixed(2) }) for key, val of ls

    @groupon = []
    @groupon.push({district: key, revenue: val }) for key, val of groupon

  render_graph: ->
    @series = []
    total_revenue = 0

    x = 0
    for city in @ls
      total_revenue += parseInt(city.revenue)
      x += 1
      if x == 10
        break

    x = 0
    for city in @ls
      rev = ((parseInt(city.revenue) / total_revenue) * 100)
      @series.push([city.district, rev])
      x += 1
      if x == 10
        break

    chart = new Highcharts.Chart({
      chart:
        renderTo: "dg"
        plotBackgroundColor: null
        plotBorderWidth: null
        plotShadow: true

      title:
        text: "Top 10 Districts"

      tooltip:
        formatter: ->
          "<b>" + @point.name + "</b>: " + Math.round(@percentage) + " %"

      plotOptions:
        pie:
          allowPointSelect: true
          cursor: "pointer"
          dataLabels:
            enabled: true
            color: "#000000"
            connectorColor: "#000000"
            formatter: ->
              "<b>" + @point.name + "</b>: " + Math.round(@percentage) + " %"

      series: [
        type: "pie"
        name: "Districts"
        data: @series
      ]
    })

  render: ->
    $("#header").html('Top districts');
    @render_table()

  render_table: ->
    source = $("#districts-data-table").html()
    template = Handlebars.compile(source)

    ls_source = template({ data: @ls })
    g_source = template({ data: @groupon })

    $("#container").html("#{ls_source}")

window.TopDistricts = TopDistricts