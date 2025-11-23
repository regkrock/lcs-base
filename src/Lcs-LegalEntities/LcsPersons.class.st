Class {
	#name : 'LcsPersons',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'querying' }
LcsPersons >> contactWithFirstName: aFirstName surname: aSurname [
	^ self
		find: [ :each | each firstName = aFirstName and: [ each surname = aSurname ] ]
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
LcsPersons >> hasContactWithFirstName: aFirstName surname: aSurname [
	^ (self contactWithFirstName: aFirstName surname: aSurname) notNil
]
