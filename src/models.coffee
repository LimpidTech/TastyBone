class TastyPieModel extends Backbone.Model
  # TODO: Figure out how to make an ID into just an id. Not the entire URI.
  idAttribute: 'resource_uri'

  url: ->
    if @id then return @id

    url = Backbone.Model.prototype.url.call @

    if url[url.length-1] != '/'
      url = url + '/'

    url

  @factory: (endpoint, bone) ->
    # Creates a nested class which accesses the given endpoint. I know. It's weird.
    class AutoTastyPieModel extends TastyPieModel
      initialize: ->
        @urlRoot = endpoint

window.TastyBone.Model = TastyPieModel

