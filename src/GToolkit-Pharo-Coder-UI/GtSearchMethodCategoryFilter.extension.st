Extension { #name : #GtSearchMethodCategoryFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodCategoryFilter class >> filterDescriptorFor: arg1 [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg2 | self forCategory: arg2 ];
		named: 'Category';
		order: 15;
		beNotDefault;
		completion: [ GtStringsCompletionStrategy new completions: [ arg1 categories ] ].
	^ tmp2 emptyDefaultValue: 'All'
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodCategoryFilter class >> globalFilterDescriptor [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg1 | self forCategory: arg1 ];
		named: 'Category';
		order: 15;
		beNotDefault.
	^ tmp2 emptyDefaultValue: 'All'
]
