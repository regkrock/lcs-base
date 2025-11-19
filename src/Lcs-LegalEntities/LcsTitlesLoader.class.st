Class {
	#name : 'LcsTitlesLoader',
	#superclass : 'LcsValueObjectsLoader',
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'data' }
LcsTitlesLoader >> data [
	^ '[{"code":"mr","description":"Mr","label":"Mr","isDefaultInstance":false},{"code":"ms","description":"Ms","label":"Ms","isDefaultInstance":false},{"code":"unknown","description":"Unknown","label":"","isDefaultInstance":true}]'
]

{ #category : 'configuration' }
LcsTitlesLoader >> targetClass [
	^ LcsTitle
]
