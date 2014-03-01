MagicForms = new Meteor.Collection("magicform")
Day = new Meteor.Collection("day")

Template.magicform.days = () ->
  formId = Session.get("formId")
  magicform = MagicForms.findOne({_id: formId})

  if magicform?
    [ignore, dayId] = window.location.pathname.split('/');

    days = [[]]
    if dayId? and !isNaN(parseInt(dayId))
      days = Day.find({_id: dayId})
    else
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
  ,
  "change .waterCheck": (evt) ->
    start = Date.now()
    response = Meteor.call('updateWater', evt.srcElement.id, evt.srcElement.checked,
      (error, result) ->
        console.log("Returned from update water: " + (Date.now() - start))
    )
}

Meteor.startup () ->
  Session.setDefault("formId", "1");
