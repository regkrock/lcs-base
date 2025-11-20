Class {
	#name : 'LcsPersons',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'queries' }
LcsPersons >> defaultInstance [
	^ self currentSystem legalEntitiesModule configuration unknownPerson
]

{ #category : 'querying' }
LcsPersons >> findWithFullName: aString [
	self find: [ :each | each fullName = aString ] ifNone: [ ^ OrderedCollection new ]
]
