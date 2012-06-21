class TastyPieCollection extends Backbone.Collection
  parse: (data) ->
    if data? and data.meta?
      @meta = data.meta

    data.objects or data

  @factory = (model, endpoint) ->
    class AutoTastyPieCollection extends TastyPieCollection
      model: model
      url: endpoint

window.TastyBone.Collection = TastyPieCollection

