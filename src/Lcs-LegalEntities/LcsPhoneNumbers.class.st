Class {
	#name : 'LcsPhoneNumbers',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'default instance' }
LcsPhoneNumbers >> defaultInstance [
	^ self currentSystem legalEntitiesModule configuration unknownPhoneNumber
]
