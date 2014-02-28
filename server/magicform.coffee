MagicForms = new Meteor.Collection("magicform")
Day = new Meteor.Collection("day")

sumByColumn = (column) ->
  (memo, item) ->
    asFloat = parseFloat(item[column])
    if asFloat and !isNaN(asFloat)
      return memo + asFloat
    else
      return memo

Meteor.methods({
  updateDay: (inputId, value) ->

    start = Date.now()

    [dayId, mealId, column] = inputId.split('_')
    mealId -= 1

    day = Day.findOne({_id: dayId})
    mealUpdate = {}
    mealKey = ['meals', mealId, column].join('.')
    mealUpdate[mealKey] = value

    day.meals[mealId][column] = value

    totalObj = {}
    totalObj[column] = _.reduce(day.meals, sumByColumn(column), 0)

    Day.update(dayId, {$set: mealUpdate})
    Day.update(dayId, {$set: totalObj})

    console.log(Date.now() - start)
})

Meteor.startup () ->

  if MagicForms.find({}, {limit: 1}).count() == 0

    days = []

    # 21 day program
    for i in [1..21]

      day = {
        _id: "#{i}",
        meals: [],
        green: 0,
        purple: 0,
        red: 0,
        yellow: 0,
        blue: 0,
        orange: 0,
        spoon: 0
      }

      # 6 meals per day
      for j in [0..5]
        day.meals.push({
          index: j+1,
          green: "",
          purple: "",
          red: "",
          yellow: "",
          blue: "",
          orange: "",
          spoon: ""
        })
      Day.insert(day)
      days.push(day._id)

    MagicForms.insert({
      _id: "1",
      days: days
    })
