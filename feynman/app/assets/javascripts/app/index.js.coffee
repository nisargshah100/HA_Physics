#= require json2
#= require jquery
#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/route

#= require_tree ./lib
#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views

class App extends Spine.Controller
  constructor: ->
    super
    # Initialize controllers:
    @append(@events = new App.Events)
    @append(@messages = new App.MessagesNew)
    @append(@messages = new App.MessagesIndex)
    #  ...
    
    Spine.Route.setup()    

window.App = App
