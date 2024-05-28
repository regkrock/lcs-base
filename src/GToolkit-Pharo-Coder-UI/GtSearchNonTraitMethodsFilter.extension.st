Extension { #name : #GtSearchNonTraitMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchNonTraitMethodsFilter class >> globalFilterDescriptor [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg1 | self new ];
		named: 'Non-trait methods';
		order: 20;
		valueNotRequired;
		beNotDefault.
	^ tmp2 yourself
]
