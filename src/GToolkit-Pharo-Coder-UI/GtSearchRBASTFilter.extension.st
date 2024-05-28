Extension { #name : #GtSearchRBASTFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchRBASTFilter class >> globalFilterDescriptor [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg1 | self sourceExpression: arg1 ];
		named: 'AST'.
	^ tmp2 order: 100
]
