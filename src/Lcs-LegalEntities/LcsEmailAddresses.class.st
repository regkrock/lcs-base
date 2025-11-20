Class {
	#name : 'LcsEmailAddresses',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'default instance' }
LcsEmailAddresses >> defaultInstance [
	^ self currentSystem legalEntitiesModule configuration unknownEmailAddress
]

{ #category : 'querying' }
LcsEmailAddresses >> findItemMatchingAddressType: anObject [
	^ self
		find: [ :each | each emailAddressType code = anObject ]
		ifNone: [ self defaultInstance ]
]
