Extension { #name : #GtSearchBinaryFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchBinaryFilter >> filterDescriptorFor: arg1 [
	| tmp2 |
	tmp2 := left filterDescriptorFor: arg1.
	^ tmp2 ifNil: [ right filterDescriptorFor: arg1 ] ifNotNil: [ tmp2 ]
]
