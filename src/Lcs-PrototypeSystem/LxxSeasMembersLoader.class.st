Class {
	#name : 'LxxSeasMembersLoader',
	#superclass : 'LcsObjectsLoader',
	#category : 'Lcs-PrototypeSystem-Core',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Core'
}

{ #category : 'private' }
LxxSeasMembersLoader >> addListInfoToMembersJson [
	| inputFile inputStream outputFile outputStream string|
	inputFile := (File named: '/Users/regkrock/SEAS/monmouthmembership/seas/members.json').
	outputFile := (File named: '/Users/regkrock/SEAS/monmouthmembership/seas/membersConverted.json') openForWrite.
	inputStream := inputFile readStream contents asString readStream.
	outputFile nextPutAll: '['.
	[ inputStream atEnd ] whileFalse: [
		string := inputStream nextLine.
		outputFile nextPutAll: string.
		inputStream atEnd ifFalse: [outputFile nextPutAll: ','].
		outputFile cr; lf
		].
	outputFile nextPutAll: ']'.
	outputFile close
	
	
]

{ #category : 'as yet unclassified' }
LxxSeasMembersLoader >> data [
	^'{
	"_id": {
		"$oid": "5d1283c61445b044c4814248"
	},
	"seas_chapter": "MONMOUTH",
	"first_name": "Eric",
	"middle_name": "",
	"last_name": "Hanan",
	"street": "48 Woodland Ave",
	"city": "Glen Ridge",
	"state": "NJ",
	"zip_code": "07028",
	"phone_number": "(H)973-259-0556  (C)973-801-9920",
	"emergency_contact_person": "Mary Hanan",
	"emergency_contact_phone": "201-994-9993",
	"password": "$2a$10$3.eDqVAQM17PWFUYJBM5gehFv24tHYXAbU4h59n9sJRDSC2kZGP5.",
	"email": "eric@beehavenbees.com",
	"release_sign_up_signature": "Eric Hanan",
	"release_date": {
		"$date": {
			"$numberLong": "1561493887097"
		}
	},
	"payment_date_2019": {
		"$date": {
			"$numberLong": "1561494499713"
		}
	},
	"boating_safety_certificate": true,
	"basic_sailing_or_equivalent": false,
	"boat_trailer_maintenance": true,
	"trailer_towing": true,
	"party_setup_cleanup": true,
	"educational_activities": true,
	"administrative_activities": false,
	"small_boat_day_setup_breakdown": true,
	"publicity_activities": false,
	"publicity_fund_raising_activities": false,
	"publicity_fair_setup_breakdown": false,
	"skipper_activity_sails": false,
	"technology": false,
	"__v": {
		"$numberInt": "0"
	},
	"order_id": "manual",
	"membership_type": "single"
}
{
	"_id": {
		"$oid": "5d1283c61445b044c4814248"
	},
	"seas_chapter": "MONMOUTH",
	"first_name": "Eric",
	"middle_name": "",
	"last_name": "Hanan2",
	"street": "48 Woodland Ave",
	"city": "Glen Ridge",
	"state": "NJ",
	"zip_code": "07028",
	"phone_number": "(H)973-259-0556  (C)973-801-9920",
	"emergency_contact_person": "Mary Hanan",
	"emergency_contact_phone": "201-994-9993",
	"password": "$2a$10$3.eDqVAQM17PWFUYJBM5gehFv24tHYXAbU4h59n9sJRDSC2kZGP5.",
	"email": "eric@beehavenbees.com",
	"release_sign_up_signature": "Eric Hanan",
	"release_date": {
		"$date": {
			"$numberLong": "1561493887097"
		}
	},
	"payment_date_2019": {
		"$date": {
			"$numberLong": "1561494499713"
		}
	},
	"boating_safety_certificate": true,
	"basic_sailing_or_equivalent": false,
	"boat_trailer_maintenance": true,
	"trailer_towing": true,
	"party_setup_cleanup": true,
	"educational_activities": true,
	"administrative_activities": false,
	"small_boat_day_setup_breakdown": true,
	"publicity_activities": false,
	"publicity_fund_raising_activities": false,
	"publicity_fair_setup_breakdown": false,
	"skipper_activity_sails": false,
	"technology": false,
	"__v": {
		"$numberInt": "0"
	},
	"order_id": "manual",
	"membership_type": "single"
}'
]

{ #category : 'converting' }
LxxSeasMembersLoader >> mongodbNanosecondsAsDate: anInteger [		 
	^ (DateAndTime fromUnixTime: (anInteger * 0.001) ) asDate
]

{ #category : 'as yet unclassified' }
LxxSeasMembersLoader >> parsedJsonData [
	"^ ( NeoJSONReader on: self new data2 readStream ) parseList"

	| inputFile inputStream |
	inputFile := File named: '/Users/regkrock/SEAS/monmouthmembership/seas/membersConverted.json'.
	inputStream := inputFile readStream contents asString readStream.
	^ (NeoJSONReader on: inputStream) parseList
]
