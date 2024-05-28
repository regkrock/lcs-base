Extension { #name : #GtSearchLiteralStringFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchLiteralStringFilter class >> globalFilterDescriptor [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg1 | self substring: arg1 ];
		named: 'Substring literal'.
	^ tmp2 order: 91
]
