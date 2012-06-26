class VelocityByHour
  fetch: ->
    $.get '/dashboard/data/velocity', (data) =>
      @parse_data(data)
      @render()

  render: ->
    $("#header").html('Best Deals / Hour')
    new Highcharts.Chart(
      chart:
        renderTo: "container"
        type: "column"

      title:
        text: "Velocity"

      xAxis:
        categories: @titles

      yAxis:
        title:
          text: "Deals per hour"

      tooltip:
        formatter: ->
          console.log(@)
          "#{@point.data.title}<br>
         #{@point.data.category}<br />
         <b>#{@y}</b> deals/hour"

      series: @series
    )

  parse_data: (data) ->
    ls = data.livingsocial
    groupon = data.groupon

    @titles = []

    @ls_data = []
    @g_data = []

    x = 1
    for deal in ls
      @titles.push x
      @ls_data.push { y: deal[0], data: deal[1] }
      x += 1


    for deal in groupon
      @g_data.push { y: deal[0], data: deal[1] }

    @series = [
      { name: "Living Social", data: @ls_data },
      { name: "Groupon", data: @g_data }
    ]

window.VelocityByHour = VelocityByHour