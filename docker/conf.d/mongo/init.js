use dormitories
db.createUser(
  {
    user: "andrey",
    pwd:  "qwe123",
    roles: [ { role: "readWrite", db: "dormitories" } ]
  }
)

db = connect("localhost:27017/dormitories","andrey","qwe123")
use dormitories
db.createCollection("people")
db.createCollection("rooms")
db.createCollection("dormitories")
db.createCollection("lodger")
db.createCollection("attendance")

db.people.insert({
      id:             207209,
      firstName:      "Andrey",
      lastName:       "Mileshin",
      patronomic:     "Aleksandrovich",
      dateOfBirth:    "08-03-1997",
      placeOfBirth:   "Saransk"
      benefit:        "FALSE",
      educationType:  "budget"
})

db.rooms.insert(
   {
      roomNumber:     "1431-3",
      roomSize:       "three persons",
      numLodgers:     1,
      disinfection:   "2019-12-12",
      bedbugs:        "FALSE"
   }
)

db.rooms.insert(
   {
      roomNumber:     "1431-3",
      roomSize:       "3 persons",
      numLodgers:     1,
      disinfection:   "2019-12-12",
      bedbugs:        "FALSE"
   }
)

db.dormitories.insert(
   {
      place:          "Vyazemsky 5/7",
      numberOfRooms:  666,
   }
)

db.dormitories.insert(
   {
      place:          "Lensovet 23A",
      numberOfRooms:  585
   }
)

db.lodger.insert(
   {
      lodger:         207209,
      roomNumber:     "1431-3",
      rebuke:         "No",
      residenceStart: "2015-09-01",
      residenceEnd:   "2021-08-31",
      paymentAmount:  1500
   }
)

db.attendance.insert(
   {
      lodger:        207209,
      time:          "2020-22-04 22:20:15",
      attendance:    "entered"
   }
)
