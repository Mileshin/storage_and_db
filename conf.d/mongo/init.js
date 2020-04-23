use dormitories
db.createUser(
  {
    user: "andrey",
    pwd: "qwe123",
    roles: [ { role: "readWrite", db: "dormitories" } ]
  }
)

db = connect("localhost:27017/dormitories","andrey","qwe123")
use dormitories
db.createCollection("people")
db.createCollection("rooms")
db.createCollection("dormitories")
db.createCollection("lodger")

db.people.insert({
      id:            207209,
      FirstName:     "Andrey",
      LastName:      "Mileshin",
      patronomic:    "Alecsandovich",
      benefit:       "FALSE",
      typeEducation: "full-time"
})

db.rooms.insert(
   {
      numRooms:      "1431-3",
      roomSize:      "three persons",
      numLodgers:    "1",
      disinfection:  "2019-12-12",
      bedbug:        "FALSE"
   }
)

db.dormitories.insert(
   {
      place:         "Vyazemsky 5/7",
      numberOfRooms: 666,
   }
)

db.lodger.insert(
   {
      lodger:        207209,
      numRooms:      "1431-3",
      rebuke:        "No",
      period_of_residence: "2015-09-01"
   }
)


