Class {
	#name : 'LcsAddressTypesLoader',
	#superclass : 'LcsValueObjectsLoader',
	#category : 'Lcs-Geography-Core',
	#package : 'Lcs-Geography',
	#tag : 'Core'
}

{ #category : 'data' }
LcsAddressTypesLoader >> data [
	^ '[{"code":"home","description":"home","label":"Home","isDefaultInstance":false},{"code":"work","description":"work","label":"Work","isDefaultInstance":false},{"code":"unknown","description":"Unknown","label":"","isDefaultInstance":true}]'
]

{ #category : 'configuration' }
LcsAddressTypesLoader >> targetClass [
	^ LcsAddressType
]
