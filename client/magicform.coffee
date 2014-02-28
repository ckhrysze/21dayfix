MagicForms = new Meteor.Collection("magicform")
Day = new Meteor.Collection("day")

Template.magicform.days = () ->
  formId = Session.get("formId")
  magicform = MagicForms.findOne({_id: formId})

  if magicform?
    days = _.map(magicform.days, (id) ->
      Day.findOne({_id: id})
    )
    return days
  else
    return [[]]

Template.magicform.events = {
  "change .numInput": (evt) ->
    start = Date.now()
    response = Meteor.call('updateDay', evt.srcElement.id, evt.srcElement.value,
      (error, result) ->
        console.log("Returned from update: " + (Date.now() - start))
    )
    console.log(Date.now() - start)
}

Meteor.startup () ->
  Session.setDefault("formId", "1");
