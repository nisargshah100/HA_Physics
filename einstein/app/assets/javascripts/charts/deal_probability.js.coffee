class DealProbability
  constructor: ->
    $("#deal_probability_template_form").live 'submit', (e) =>
      e.preventDefault()
      @compute()

  fetch: ->
    $("#header").html('Deal Probability');
    source = $("#deal_probability_template").html()
    template = Handlebars.compile(source)
    $("#container").html(template())

  compute: ->
    cat = $("#dpt_cat").val()
    date = $("#dpt_date").val()
    loc = $("#dpt_loc").val()

    if not date or not cat
      alert 'Date & Category is required'
      return

    $.get "/dashboard/data/deal_probability", {term: cat, time: date, loc: loc}, (data) =>
      @parse_data(data)
      @render()

  parse_data: (data) ->
    @analysis = {
      will_run: if data.analysis[0] then 'will' else 'will not'
      diff: data.analysis[1]
      slope: parseFloat(data.analysis[2]).toFixed(3)
    }
    
    @deals = data.deals

  render: ->
    source = $("#deal_prob_search_template").html()
    template = Handlebars.compile(source)
    $("#deal_probability_template_search").html(template({ cat: $("#dpt_cat").val(), date: $("#dpt_date").val(), loc: $("#dpt_loc").val(), analysis: @analysis, deals: @deals }))

window.DealProbability = DealProbability