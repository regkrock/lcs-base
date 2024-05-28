Extension { #name : #GtTraitDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtTraitDefinition >> browseFrom: arg1 [
	self class environment
		at: self name
		ifPresent: [ :arg2 | arg1 currentTarget phlow spawnTool: (GtClassCoderTool observedClass: arg2) ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtTraitDefinition >> readers [
	<return: #Collection of: #GtCodeDefinitionViewer>
	^ {self category categoryReader}
]
