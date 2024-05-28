Extension { #name : #GtSlotsDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotsDefinition >> modelClassFrom: arg1 [
	^ arg1 classNamed: self definition topMostParent name
]
