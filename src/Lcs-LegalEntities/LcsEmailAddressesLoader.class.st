Class {
	#name : #LcsEmailAddressesLoader,
	#superclass : #LcsObjectsLoader,
	#category : #'Lcs-LegalEntities'
}

{ #category : #data }
LcsEmailAddressesLoader >> data [
	^ ''
]

{ #category : #configuration }
LcsEmailAddressesLoader >> targetClass [
	^ LcsEmailAddress
]
