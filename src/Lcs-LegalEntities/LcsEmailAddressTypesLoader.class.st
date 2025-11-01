Class {
	#name : #LcsEmailAddressTypesLoader,
	#superclass : #LcsValueObjectsLoader,
	#category : #'Lcs-LegalEntities'
}

{ #category : #data }
LcsEmailAddressTypesLoader >> data [
	^ '[
		{"code":"home","description":"Home","label":"Home","isDefaultInstance":false},
		{"code":"work","description":"Work","label":"Work","isDefaultInstance":false},		
		{"code":"unknown","description":"","label":"","isDefaultInstance":true}		
		]'
]

{ #category : #configuration }
LcsEmailAddressTypesLoader >> targetClass [
	^ LcsEmailAddressType
]
