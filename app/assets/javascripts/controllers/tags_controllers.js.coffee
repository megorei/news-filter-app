App.TagsController = Ember.ArrayController.extend
  sortProperties: ['title']
  sortAscending: true

  actions:
    newTag: ->
      @transitionTo 'tags.new'

    toggleTag: (tag)->
      if tag.get('selected')
        @transitionToRoute 'articles'
      else
        @transitionToRoute 'articles.byTag', tag

  resetTagSelection: ->
    @get('model').forEach (tag)->
      tag.set 'selected', false