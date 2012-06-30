class ProjectedRevenue
  constructor: ->
    $("#projected-revenue-search-form").live 'submit', (e) =>
      e.preventDefault()
      $.get '/dashboard/data/projected_revenue', { q: $("#projected-revenue-search-box").val() }, @handle_search

  fetch: ->
    source = $("#projected-revenue-search").html()
    template = Handlebars.compile(source)

    $("#header").html('Projected Revenue')
    $("#container").html(template())

    @fetch_revenue()


  fetch_revenue: ->
    $.get '/dashboard/data/projected_revenue', @handle_search

  handle_search: (data) =>
    source = $("#projected-revenue-table").html()
    template = Handlebars.compile(source)

    i = 0
    for rev in data
      data[i][0] = (rev[0] / 100).toFixed(2)
      i += 1

    $("#projected-revenue-html").html(template({revenues: data}))

window.ProjectedRevenue = ProjectedRevenue