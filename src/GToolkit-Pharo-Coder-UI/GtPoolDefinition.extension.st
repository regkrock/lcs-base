Extension { #name : #GtPoolDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPoolDefinition >> browseFrom: arg1 [
	self class environment
		at: self name
		ifPresent: [ :arg2 | arg1 currentTarget phlow spawnTool: (GtClassCoderTool observedClass: arg2) ]
]
