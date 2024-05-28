Extension { #name : #GtSearchInstanceMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInstanceMethodsFilter class >> globalFilterDescriptor [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg1 | self new ];
		named: 'Instance methods';
		order: 16;
		valueNotRequired;
		beNotDefault.
	^ tmp2 yourself
]
