Extension { #name : #GtSearchSubclassResponsibilityMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchSubclassResponsibilityMethodsFilter class >> globalFilterDescriptor [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg1 | self new ];
		named: 'Abstract methods';
		order: 18;
		valueNotRequired;
		beNotDefault.
	^ tmp2 yourself
]
