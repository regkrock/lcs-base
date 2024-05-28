Extension { #name : #GtSearchRBPatternFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchRBPatternFilter class >> globalFilterDescriptor [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg1 | self pattern: arg1 ];
		named: 'RBPattern'.
	^ tmp2 order: 100
]
