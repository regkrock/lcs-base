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
