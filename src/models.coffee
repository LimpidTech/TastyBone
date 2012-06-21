class TastyPieModel extends Backbone.Model
  url: ->
    # It seems that TastyPie really likes leading slahes. This is a bad thing.
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

