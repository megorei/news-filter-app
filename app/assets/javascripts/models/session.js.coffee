App.Session = DS.Model.extend
  authToken: DS.attr 'string'
  userId:    DS.attr 'string'