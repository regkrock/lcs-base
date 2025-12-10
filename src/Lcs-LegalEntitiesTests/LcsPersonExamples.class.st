Class {
	#name : 'LcsPersonExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-LegalEntitiesTests-Examples',
	#package : 'Lcs-LegalEntitiesTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsPersonExamples >> globalEmailAddressesPendingAddsSize [
	^ self currentSystem legalEntitiesModule emailAddresses pendingAdds size
]

{ #category : 'examples' }
LcsPersonExamples >> johnDoe [
	<gtExample>
	| person |
	self ensureCurrentSystemIsDemoSystem.
	person := LcsPerson new
			firstName: 'John';
			familyName: 'Doe'.	"Because person is automatically added to a global collection, no need to explicitly add the parent"
	self currentSystem legalEntitiesModule persons includes: person.
	self
		assert: (self currentSystem legalEntitiesModule
				hasContactWithFirstName: person firstName
				familyName: person familyName).
	^ person
]

{ #category : 'examples' }
LcsPersonExamples >> johnFreeman [
	<gtExample>
	| person |
	self ensureCurrentSystemIsDemoSystem.
	person := 
		self newPerson
			familyName: 'Freeman';
			firstName: 'John';
			middleNames: 'Edgar';
			dateOfBirth: '01-01-1990';
			gender: 'male';
			title: 'mr';
			yourself.
	self assert: person title code equals: 'mr'.
	self assert: person familyName equals: 'Freeman'.
	self assert: person firstName equals: 'John'.
	self assert: person middleNames equals: 'Edgar'.
	self assert: person dateOfBirth asString equals: '1 January 1990'.
	self assert: person gender code = 'male'.
	self assert: person title code = 'mr'.
	self assert: person fullName = 'John Edgar Freeman'.
	self assert: person entityName = 'John Edgar Freeman'.
	self assert: person postalAddresses hasNoElements.
	self assert: person emailAddresses hasNoElements.
	self assert: person phoneNumbers hasNoElements.
	self currentSystem legalEntitiesModule persons includes: person.

	^ person
]

{ #category : 'examples' }
LcsPersonExamples >> johnFreemanHomeEmail [
	<gtExample>
	^ LcsEmailAddress new
		emailAddressType: 'home';
		email: 'johnfreeman@gmail.com';
		yourself
]

{ #category : 'examples' }
LcsPersonExamples >> johnFreemanWithAddress [
	<gtExample>
	| person |
	person := self johnFreeman.
	person homeAddress: (LcsAddress new addressType: 'home').
	person homeAddress city: 'Godfrey'.
	self assert: person homeAddress city equals: 'Godfrey'.
	
	person homeAddress streetNumber: '12345'.
	self assert: person homeAddress streetNumber equals: '12345'.
	
	person homeAddress streetName: 'Witt Road'.
	self assert: person homeAddress streetName equals: 'Witt Road'.
	
	person homeAddress additionalDeliveryInformation: 'RR 2'.
	self assert: person homeAddress additionalDeliveryInformation equals: 'RR 2'.
	
	person homeAddress country: 'CAN'.
	self assert: person homeAddress country isoCode3 equals: 'CAN'.
	self assert: (person homeAddress province isKindOf: LcsCanadaSubdivision).
	self assert: (person homeAddress province isoCode = '').
	
	person homeAddress province: 'ON'.
	self assert: person homeAddress province isoCode equals: 'ON'.
	
	person homeAddress postCode: 'K8A 6W8'.
	self assert: person homeAddress postCode equals: 'K8A 6W8'.

	^ person
]

{ #category : 'examples' }
LcsPersonExamples >> johnFreemanWithEmailAddresses [
	<gtExample>
	| person homeEmail workEmail originalPendingAddSize |
	self ensureCurrentSystemIsDemoSystem.
	originalPendingAddSize := self globalEmailAddressesPendingAddsSize.
	person := self johnFreeman.
	self
		assert: person homeEmailAddress
		equals: person emailAddresses defaultInstance.

	homeEmail := self johnFreemanHomeEmail.
	person homeEmailAddress: homeEmail.
	self assert: person homeEmailAddress equals: homeEmail.
	self assert: person emailAddresses pendingAdds size equals: 1.
	self
		assert: self globalEmailAddressesPendingAddsSize
		equals: originalPendingAddSize + 1.

	workEmail := self johnFreemanWorkEmail.
	person workEmailAddress: workEmail.
	self assert: person workEmailAddress equals: workEmail.
	self assert: person emailAddresses pendingAdds size equals: 2.
	self
		assert: self globalEmailAddressesPendingAddsSize
		equals: originalPendingAddSize + 2.
	^ person
]

{ #category : 'examples' }
LcsPersonExamples >> johnFreemanWorkEmail [
	<gtExample>
	^ LcsEmailAddress new
		emailAddressType: 'work';
		email: 'johnfreemanWork@gmail.com';
		yourself
]

{ #category : 'examples' }
LcsPersonExamples >> newPerson [
	<gtExample>
	| person |
	self ensureCurrentSystemIsDemoSystem.
	person := LcsPerson new.
	self assert: person title code equals: 'unknown'.
	self assert: person familyName isEmpty.
	self assert: person firstName isEmpty.
	self assert: person middleNames isEmpty.
	self assert: person dateOfBirth asString equals: Date today asString.
	self assert: person gender code = 'unknownGender'.
	self assert: person fullName = '  '.
	self assert: person entityName = '  '.
	self assert: (person postalAddresses isKindOf: LcsAddresses).
	self assert: (person emailAddresses isKindOf: LcsEmailAddresses).
	self assert: (person phoneNumbers isKindOf: LcsPhoneNumbers).
	self assert: person postalAddresses hasNoElements.
	self assert: person emailAddresses hasNoElements.
	self assert: person phoneNumbers hasNoElements.
	self currentSystem legalEntitiesModule persons includes: person.

	^ person
]

{ #category : 'examples' }
LcsPersonExamples >> samSmith [
	<gtExample>
	| person |
	self ensureCurrentSystemIsDemoSystem.
	person := LcsPerson new
			firstName: 'Sam';
			familyName: 'Smith'.
	self currentSystem legalEntitiesModule persons includes: person.
	^ person
]
