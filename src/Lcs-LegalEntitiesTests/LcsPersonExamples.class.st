Class {
	#name : #LcsPersonExamples,
	#superclass : #LcsObjectExamples,
	#category : #'Lcs-LegalEntitiesTests-Examples'
}

{ #category : #examples }
LcsPersonExamples >> johnFreeman [
	<gtExample>
	| person |
	self ensureCurrentSystemIsMainSystem.
	person := 
		LcsPerson new
			surname: 'Freeman';
			firstName: 'John';
			middleNames: 'Edgar';
			dateOfBirth: '01-01-1990';
			gender: 'male';
			yourself.
	self assert: person surname equals: 'Freeman'.
	self assert: person firstName equals: 'John'.
	self assert: person middleNames equals: 'Edgar'.
	self assert: person dateOfBirth asString equals: '1 January 1990'.
	self assert: person gender code = 'male'.
	self assert: person fullName = 'John Edgar Freeman'.
	self assert: person entityName = 'John Edgar Freeman'.
	self assert: (person mainAddress isKindOf: LcsAddress).
	self assert: (person emailAddress isKindOf: LcsEmailAddress).
	self assert: person emailAddress email isEmpty.
	
	^ person
]

{ #category : #examples }
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
	"self assert: (person mainAddress province isKindOf: LcsCanadaSubdivision).
	self assert: (person mainAddress province isoCode = '')."
	
	person mainAddress province: 'ON'.
	self assert: person mainAddress province isoCode equals: 'ON'.
	
	"person mainAddress postalCode: 'K8A 6W8'.
	person mainAddress postalCode asString equals: 'K8A 6W8'."

	^ person
]
