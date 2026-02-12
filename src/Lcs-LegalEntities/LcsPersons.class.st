Class {
	#name : 'LcsPersons',
	#superclass : 'LcsDomainCollection',
	#instVars : [
		'unknownPerson'
	],
	#category : 'Lcs-LegalEntities-Core',
	#package : 'Lcs-LegalEntities',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsPersons class >> unknownPersonSlotDefinition [
	<accessorSlotDefinition>
	^ LcsUnknownInstanceSlot new
			slotName: 'unknownPerson';
			addSlotType: LcsUnknownPerson;
			yourself
]

{ #category : 'querying' }
LcsPersons >> contactWithFirstName: aFirstName familyName: aFamilyName [
	^ self
		find: [ :each | each firstName = aFirstName and: [ each familyName = aFamilyName ] ]
		ifNone: [ nil ]
]

{ #category : 'queries' }
LcsPersons >> defaultInstance [
	^ self unknownPerson
]

{ #category : 'querying' }
LcsPersons >> findWithFullName: aString [
	^ self find: [ :each | each fullName = aString ] ifNone: [ ^ OrderedCollection new ]
]

{ #category : 'querying' }
LcsPersons >> hasContactWithFirstName: aFirstName familyName: aFamilyName [
	^ (self contactWithFirstName: aFirstName familyName: aFamilyName) notNil
]

{ #category : 'accessing' }
LcsPersons >> unknownPerson [
	^ self slotVarNamed: 'unknownPerson'
]

{ #category : 'accessing' }
LcsPersons >> unknownPerson: anObject [
	self slotVarNamed: 'unknownPerson' put: anObject
]
