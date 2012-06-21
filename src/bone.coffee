window.TastyBone = {}
TastyBone = window.TastyBone

class Bone
  collections: {}

  constructor: (@original_url, options) ->
    # TODO: Implement authentication options.

    _.extend @, Backbone.Events

    options = options or {}

    jQuery.get @original_url, options, (endpoints) =>
      _.each endpoints, (endpoint, name) =>
        if name[0] == '_' then return

        capitalizedName = name[0].toUpperCase() + name.slice(1)
        model = TastyBone.Model.factory endpoint.list_endpoint, @

        next_collection = TastyBone.Collection.factory model,
                                                      endpoint.list_endpoint

        @collections[capitalizedName + 'Collection'] = next_collection

      @.trigger 'ready', @

TastyBone.Bone = Bone

