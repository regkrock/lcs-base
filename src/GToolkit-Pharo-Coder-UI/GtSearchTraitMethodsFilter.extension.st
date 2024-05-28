Extension { #name : #GtSearchTraitMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchTraitMethodsFilter class >> globalFilterDescriptor [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg1 | self new ];
		named: 'Trait methods';
		order: 19;
		valueNotRequired;
		beNotDefault.
	^ tmp2 yourself
]
