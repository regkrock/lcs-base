Extension { #name : #GtSearchClassMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchClassMethodsFilter class >> globalFilterDescriptor [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg1 | self new ];
		named: 'Class methods';
		order: 17;
		valueNotRequired;
		beNotDefault.
	^ tmp2 yourself
]
