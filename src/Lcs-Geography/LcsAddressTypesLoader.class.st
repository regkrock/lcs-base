Class {
	#name : 'LcsAddressTypesLoader',
	#superclass : 'LcsValueObjectsLoader',
	#category : 'Lcs-Geography-Domain',
	#package : 'Lcs-Geography',
	#tag : 'Domain'
}

{ #category : 'data' }
LcsAddressTypesLoader >> data [
	^ '[{"code":"home","description":"home","label":"Home","isDefaultInstance":false},{"code":"work","description":"work","label":"Work","isDefaultInstance":false},{"code":"unknown","description":"Unknown","label":"","isDefaultInstance":true}]'
]

{ #category : 'configuration' }
LcsAddressTypesLoader >> targetClass [
	^ LcsAddressType
]
