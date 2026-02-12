Class {
	#name : 'LcsPhoneNumbers',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-LegalEntities-Core',
	#package : 'Lcs-LegalEntities',
	#tag : 'Core'
}

{ #category : 'default instance' }
LcsPhoneNumbers >> defaultInstance [
	^ self error: 'This must be implememted'
]

{ #category : 'default instance' }
LcsPhoneNumbers >> unknownInstance [
	^ self currentSystem legalEntitiesModule phoneNumbers unknownInstance
]
