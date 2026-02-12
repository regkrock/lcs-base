Class {
	#name : 'LcsPhoneNumberTypesLoader',
	#superclass : 'LcsValueObjectsLoader',
	#category : 'Lcs-LegalEntities-Core',
	#package : 'Lcs-LegalEntities',
	#tag : 'Core'
}

{ #category : 'data' }
LcsPhoneNumberTypesLoader >> data [
	^ '[{"code":"home","description":"home","label":"Home","isDefaultInstance":false},
{"code":"cell","description":"cell","label":"Cell","isDefaultInstance":false},
{"code":"work","description":"work","label":"Work","isDefaultInstance":false},{"code":"unknown","description":"Unknown","label":"","isDefaultInstance":true}]'
]

{ #category : 'configuration' }
LcsPhoneNumberTypesLoader >> targetClass [
	^ LcsPhoneNumberType
]
