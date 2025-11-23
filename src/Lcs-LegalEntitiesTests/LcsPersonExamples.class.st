Class {
	#name : 'LcsPersonExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-LegalEntitiesTests-Examples',
	#package : 'Lcs-LegalEntitiesTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsPersonExamples >> johnDoe [
	<gtExample>
	| person |
	self ensureCurrentSystemIsDemoSystem.
	person := LcsPerson new
			firstName: 'John';
			surname: 'Doe'.
	"Because person is automatically added to a global collection, no need to explicitly add the parent"
	^ person
]

{ #category : 'examples' }
LcsPersonExamples >> johnFreeman [
	<gtExample>
	| person |
	self ensureCurrentSystemIsDemoSystem.
	person := 
		LcsPerson new
			surname: 'Freeman';
			firstName: 'John';
			middleNames: 'Edgar';
			dateOfBirth: '01-01-1990';
			gender: 'male';
			title: 'mr';
			yourself.
	self assert: person title code equals: 'mr'.
	self assert: person surname equals: 'Freeman'.
	self assert: person firstName equals: 'John'.
	self assert: person middleNames equals: 'Edgar'.
	self assert: person dateOfBirth asString equals: '1 January 1990'.
	self assert: person gender code = 'male'.
	self assert: person title code = 'mr'.
	self assert: person fullName = 'John Edgar Freeman'.
	self assert: person entityName = 'John Edgar Freeman'.
	self assert: (person mainAddress isKindOf: LcsAddress).
	self assert: (person emailAddresses isKindOf: LcsEmailAddresses).
	self assert: person emailAddresses hasNoElements.
	
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
	
	person mainAddress city: 'Godfrey'.
	self assert: person mainAddress city equals: 'Godfrey'.
	
	person mainAddress streetNumber: '12345'.
	self assert: person mainAddress streetNumber equals: '12345'.
	
	person mainAddress streetName: 'Witt Road'.
	self assert: person mainAddress streetName equals: 'Witt Road'.
	
	person mainAddress additionalDeliveryInformation: 'RR 2'.
	self assert: person mainAddress additionalDeliveryInformation equals: 'RR 2'.
	
	person mainAddress country: 'CAN'.
	self assert: person mainAddress country isoCode3 equals: 'CAN'.
	self assert: (person mainAddress province isKindOf: LcsCanadaSubdivision).
	self assert: (person mainAddress province isoCode = '').
	
	person mainAddress province: 'ON'.
	self assert: person mainAddress province isoCode equals: 'ON'.
	
	person mainAddress postCode: 'K8A 6W8'.
	self assert: person mainAddress postCode equals: 'K8A 6W8'.

	^ person
]

{ #category : 'examples' }
LcsPersonExamples >> johnFreemanWithEmailAddresses [
	<gtExample>
	| person homeEmail workEmail originalPendingAddSize |
	originalPendingAddSize := self currentSystem legalEntitiesModule emailAddresses pendingAdds size.
	person := self johnFreeman.
	self assert: person emailAddresses hasNoElements.
	self
		assert: person homeEmailAddress
		equals: person emailAddresses defaultInstance.
	homeEmail := self johnFreemanHomeEmail.
	person homeEmailAddress: homeEmail.
	self assert: person homeEmailAddress equals: homeEmail.
	self assert: person emailAddresses pendingAdds size equals: 1.
	workEmail := self johnFreemanWorkEmail.
	person workEmailAddress: workEmail.
	self assert: person workEmailAddress equals: workEmail.
	self assert: person emailAddresses pendingAdds size equals: 2.
	self
		assert: self currentSystem legalEntitiesModule emailAddresses pendingAdds size
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
LcsPersonExamples >> samSmith [
	<gtExample>
	| person |
	self ensureCurrentSystemIsDemoSystem.
	person := LcsPerson new
			firstName: 'Sam';
			surname: 'Smith'.
	^ person
]
