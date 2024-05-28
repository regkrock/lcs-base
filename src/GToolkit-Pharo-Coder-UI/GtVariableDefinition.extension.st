Extension { #name : #GtVariableDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtVariableDefinition >> browseFrom: arg1 [
	arg1 currentTarget phlow spawnObject: self
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtVariableDefinition >> browseReferencesFrom: arg1 [
	| tmp1 tmp2 |
	(tmp1 := parent classOrMetaClass)
		ifNotNil: [ (tmp2 := tmp1 bindingOf: self originalName)
				ifNotNil: [ arg1 currentTarget phlow spawnObject: (GtSearchReferencesFilter literal: tmp2) ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtVariableDefinition >> inspectFrom: arg1 [
	arg1 currentTarget phlow spawnObject: self value
]
