Class {
	#name : 'LcsPersons',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'querying' }
LcsPersons >> contactWithFirstName: aFirstName familyName: aFamilyName [
	^ self
		find: [ :each | each firstName = aFirstName and: [ each familyName = aFamilyName ] ]
		ifNone: [ nil ]
]

{ #category : 'queries' }
LcsPersons >> defaultInstance [
	^ self currentSystem legalEntitiesModule configuration unknownPerson
]

{ #category : 'querying' }
LcsPersons >> findWithFullName: aString [
	^ self find: [ :each | each fullName = aString ] ifNone: [ ^ OrderedCollection new ]
]

{ #category : 'querying' }
LcsPersons >> hasContactWithFirstName: aFirstName familyName: aFamilyName [
	^ (self contactWithFirstName: aFirstName familyName: aFamilyName) notNil
]
