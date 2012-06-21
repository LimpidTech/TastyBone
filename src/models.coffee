class TastyPieModel extends Backbone.Model
  # TODO: Figure out how to make an ID into just an id. Not the entire URI.
  idAttribute: 'resource_uri'

  url: ->
    if @id? then return @id

    Backbone.Model.prototype.url.call @

  @factory: (endpoint, bone) ->
    # Creates a nested class which accesses the given endpoint. I know. It's weird.
    class AutoTastyPieModel extends TastyPieModel
      initialize: ->
        @urlRoot = endpoint

window.TastyBone.Model = TastyPieModel

