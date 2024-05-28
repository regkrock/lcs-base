Extension { #name : #GtSubstringFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSubstringFilter class >> globalFilterDescriptor [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg1 | self substring: arg1 ];
		named: 'Substring'.
	^ tmp2 order: 90
]
