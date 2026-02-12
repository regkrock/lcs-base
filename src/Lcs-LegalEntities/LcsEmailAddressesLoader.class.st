Class {
	#name : 'LcsEmailAddressesLoader',
	#superclass : 'LcsObjectsLoader',
	#category : 'Lcs-LegalEntities-Core',
	#package : 'Lcs-LegalEntities',
	#tag : 'Core'
}

{ #category : 'data' }
LcsEmailAddressesLoader >> data [
	^ ''
]

{ #category : 'configuration' }
LcsEmailAddressesLoader >> targetClass [
	^ LcsEmailAddress
]
