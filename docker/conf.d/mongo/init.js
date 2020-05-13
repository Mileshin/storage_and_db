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
      id:             0,
      firstName:      "Ivan",
      lastName:       "Ivanov",
      patronomic:     "Ivanovich",
      dateOfBirth:    "1980-07-04",
      placeOfBirth:   "London",
      benefit:        "FALSE",
      educationType:  "budget"
})

db.people.insert({
      id:             1,
      firstName:      "Sergey",
      lastName:       "Ivanov",
      patronomic:     "Ivanovich",
      dateOfBirth:    "1980-07-04",
      placeOfBirth:   "London",
      benefit:        "FALSE",
      educationType:  "budget"
})

db.people.insert({
      id:             2,
      firstName:      "Alisa",
      lastName:       "Sergeevna",
      patronomic:     "Yandex",
      dateOfBirth:    "2015-07-04",
      placeOfBirth:   "Moskva",
      benefit:        "FALSE",
      educationType:  "budget"
	}
)

db.people.insert({
      id:             3,
      firstName:      "Ochen",
      lastName:       "Umniy",
      patronomic:     "Chelovek",
      dateOfBirth:    "1960-07-04",
      placeOfBirth:   "Ladoga",
      benefit:        "FALSE",
      educationType:  "budget"
	}
)

db.rooms.insert({
      roomNumber:     "1101-1",
      roomSize:       "3 persons",
      numLodgers:     3,
      disinfection:   "2019-12-12",
      bedbugs:        "FALSE"
   }
)

db.rooms.insert({
      roomNumber:     "1221-2",
      roomSize:       "3 persons",
      numLodgers:     1,
      disinfection:   "2019-11-12",
      bedbugs:        "FALSE"
   }
)

db.rooms.insert({
      roomNumber:     "1323-1",
      roomSize:       "3 persons",
      numLodgers:     2,
      disinfection:   "2019-12-10",
      bedbugs:        "FALSE"
   }
)

db.dormitories.insert({
      place:          "Vyazemsky 5/7",
      numberOfRooms:  666,
   }
)

db.dormitories.insert({
      place:          "Lensovet 23A",
      numberOfRooms:  585
   }
)

db.lodger.insert({
      lodger:         0,
      roomNumber:     "1101-1",
      rebuke:         "No",
      residenceStart: "2002-09-01",
      residenceEnd:   "2004-08-31",
      paymentAmount:  1200
   }
)

db.lodger.insert({
      lodger:         1,
      roomNumber:     "1101-1",
      rebuke:         "No",
      residenceStart: "2002-09-01",
      residenceEnd:   "2004-08-31",
      paymentAmount:  1200
   }
)

db.lodger.insert({
      lodger:         2,
      roomNumber:     "1221-2",
      rebuke:         "No",
      residenceStart: "2015-09-01",
      residenceEnd:   "2016-08-31",
      paymentAmount:  1500
   }
)

db.lodger.insert({
      lodger:         3,
      roomNumber:     "1323-1",
      rebuke:         "No",
      residenceStart: "2015-09-01",
      residenceEnd:   "2016-08-31",
      paymentAmount:  1500
   }
)

db.attendance.insert({
      lodger:        0,
      time:          "2004-07-04 22:20:15",
      attendance:    "left"
   }
)

db.attendance.insert({
      lodger:        1,
      time:          "2004-07-04 22:21:14",
      attendance:    "left"
   }
)

db.attendance.insert({
      lodger:        2,
      time:          "2015-07-04 22:50:05",
      attendance:    "left"
   }
)

db.attendance.insert({
      lodger:        3,
      time:          "2019-07-04 12:30:04",
      attendance:    "arrived"
   }
)
