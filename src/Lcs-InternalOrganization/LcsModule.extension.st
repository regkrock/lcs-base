Extension { #name : 'LcsModule' }

{ #category : '*Lcs-InternalOrganization' }
LcsModule >> internalOrganizationModule [
	^ self moduleNamed: LcsInternalOrganizationModule defaultModuleName
]
