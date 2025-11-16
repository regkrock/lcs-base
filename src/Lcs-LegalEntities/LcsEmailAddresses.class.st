Class {
	#name : #LcsEmailAddresses,
	#superclass : #LcsDomainCollection,
	#category : #'Lcs-LegalEntities'
}

{ #category : #'default instance' }
LcsEmailAddresses >> defaultInstance [
	^ self currentSystem legalEntitiesModule configuration unknownEmailAddress
]
