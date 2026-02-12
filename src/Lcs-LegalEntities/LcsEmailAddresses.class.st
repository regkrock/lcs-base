Class {
	#name : 'LcsEmailAddresses',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-LegalEntities-Core',
	#package : 'Lcs-LegalEntities',
	#tag : 'Core'
}

{ #category : 'default instance' }
LcsEmailAddresses >> defaultInstance [
	^ self error: 'This needs to be implemented'
]

{ #category : 'querying' }
LcsEmailAddresses >> findItemMatchingAddressType: anObject [
	^ self
		find: [ :each | each emailAddressType code = anObject ]
		ifNone: [ self defaultInstance ]
]

{ #category : 'default instance' }
LcsEmailAddresses >> unknownInstance [
	^ self currentSystem legalEntitiesModule emailAddresses unknownInstance
]
