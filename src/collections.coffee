class TastyPieCollection extends Backbone.Collection
  url: (data) ->
    if @models? and @models.length > 0
      pull_id = (from) ->
        to = from.split '/'
        to = to[to.length - 2]

      idList = _.pluck @models, 'id'
      idList = _.reduce idList, (left, right) ->
        return left + ';' + (pull_id right)
      idList = pull_id idList

      return @urlRoot + 'set/' + idList

    @urlRoot

  parse: (data) ->
    if data? and data.meta?
      @meta = data.meta

    data.objects or data

  @factory = (model, endpoint) ->
    class AutoTastyPieCollection extends TastyPieCollection
      model: model
      urlRoot: endpoint

window.TastyBone.Collection = TastyPieCollection

