Extension { #name : 'LcsModule' }

{ #category : '*Lcs-LegalEntities' }
LcsModule >> legalEntitiesModule [
	^ self moduleNamed: LcsLegalEntitiesModule defaultModuleName
]
