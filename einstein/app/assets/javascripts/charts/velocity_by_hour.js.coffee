class VelocityByHour
  fetch: ->
    $.get '/dashboard/data/velocity', (data) =>
      @parse_data(data)
      @render()

  render: ->
    html = """
      <ul class="nav nav-tabs" id="myTab">
        <li class="active"><a href="#graph" data-toggle="tab">Graph</a></li>
        <li><a href="#data" data-toggle="tab">Data</a></li>
      </ul>
       
      <div class="tab-content">
        <div class="tab-pane active" id="graph" >Loading...</div>
        <div class="tab-pane" id="data">Loading...</div>
      </div>
    """

    $("#container").html(html)
    $("#header").html('Fastest Growing Deals')

    @render_graph()
    @render_table()

  render_table: ->
    source = $("#velocity-data-table").html()
    template = Handlebars.compile(source)

    ls_source = template({ data: @ls })
    g_source = template({ data: @groupon })

    $("#data").html("<h3>LivingSocial</h3><br />#{ls_source}")

  render_graph: ->
    new Highcharts.Chart(
      chart:
        renderTo: "graph"
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
          "#{@point.data.title}<br>
        #{@point.data.category}<br />
        <b>#{@y}</b> deals/hour"

      series: @series
    )

  parse_data: (data) ->
    @ls = data.livingsocial
    @groupon = data.groupon

    @titles = []

    @ls_data = []
    @g_data = []

    x = 1
    for deal in @ls
      @titles.push x
      @ls_data.push { y: deal[0], data: deal[1] }
      x += 1


    for deal in @groupon
      @g_data.push { y: deal[0], data: deal[1] }

    @series = [
      { name: "Living Social", data: @ls_data }
     #  { name: "Groupon", data: @g_data }
    ]

window.VelocityByHour = VelocityByHour