# http://emberjs.com/guides/models/using-the-store/
# http://emberjs.com/guides/models/using-the-store/


App.ApplicationAdapter = DS.RESTAdapter.extend
  namespace: 'v1'
  pathForType: (type) ->
    Ember.String.pluralize(Ember.String.underscore(type))


App.Store = DS.Store.extend
  # Override the default adapter with the `DS.ActiveModelAdapter` which
  # is built to work nicely with the ActiveModel::Serializers gem.
  adapter: App.ApplicationAdapter
