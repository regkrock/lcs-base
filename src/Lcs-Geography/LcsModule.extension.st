Extension { #name : 'LcsModule' }

{ #category : '*Lcs-Geography' }
LcsModule >> geographyModule [
	^ self moduleNamed: LcsGeographyModule defaultModuleName
]
