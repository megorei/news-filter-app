//Origin http://stackoverflow.com/questions/14999132/ember-sort-array-by-multiple-properties-in-multiple-directions

(function () {

  var get = Ember.get, set = Ember.set, forEach = Ember.EnumerableUtils.forEach;

  /**
   * extends the SortableMixin by allowing sorting by multiple orders.
   *
   * sortProperties - array of strings
   * sortAscending - default sort order
   * sortAscendingProperties - properties which are listed here will be sorted in ascending order, those which are not listed - will be sorted according to sortAscending
   */
  Ember.MultiSortableMixin = Ember.Mixin.create(Ember.SortableMixin, {
    /**
     Specifies the arrangedContent's sort direction

     @property {Array} sortAscendingProperties
     */
    sortAscendingProperties: null,
    orderBy: function (item1, item2) {
      var result = 0,
          sortProperties = get(this, 'sortProperties'),
          sortAscending = get(this, 'sortAscending'),
          sortAscendingProperties = get(this, 'sortAscendingProperties');

      Ember.assert("you need to define `sortProperties`", !!sortProperties);

      forEach(sortProperties, function (propertyName) {
        if (result === 0) {
          result = Ember.compare(get(item1, propertyName), get(item2, propertyName));
          //use default sortAscending if propertyName is not listed in sortAscendingProperties
          var sa = (sortAscendingProperties && sortAscendingProperties.indexOf(propertyName) > -1) || sortAscending;
          if ((result !== 0) && !sa) {
            result = (-1) * result;
          }
        }
      });

      return result;
    },
//overrided to add more watched props. TODO - the contents of this method is the same as parent's - find the way to just add watched stuff
    arrangedContent: Ember.computed('content', 'sortProperties.@each', 'sortAscendingProperties.@each', 'sortAscending', function (key, value) {
      var content = get(this, 'content'),
          isSorted = get(this, 'isSorted'),
          sortProperties = get(this, 'sortProperties'),
          self = this;

      if (content && isSorted) {
        content = content.slice();
        content.sort(function (item1, item2) {
          return self.orderBy(item1, item2);
        });
        forEach(content, function (item) {
          forEach(sortProperties, function (sortProperty) {
            Ember.addObserver(item, sortProperty, this, 'contentItemSortPropertyDidChange');
          }, this);
        }, this);
        return Ember.A(content);
      }

      return content;
    }),
// unneeded in this mixin, overrided to disable functionality from SortableMixin. TODO - find a way to just remove it
    sortAscendingDidChange: Ember.observer(function () {
//empty
    }, 'sortAscending')
  });

})();