Extension { #name : #GtSearchMethodsWithPackagePatternFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithPackagePatternFilter class >> filterDescriptorFor: arg1 [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg2 | self pattern: arg2 ];
		named: 'Package';
		order: 30.
	^ tmp2
		completion: [ GtStringsCompletionStrategy new completions: [ arg1 packageNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithPackagePatternFilter class >> globalFilterDescriptor [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg1 | self pattern: arg1 ];
		named: 'Package';
		order: 30.
	^ tmp2
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: RPackageOrganizer default packageNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithPackagePatternFilter class >> packageFilterDescriptor [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg1 | self pattern: arg1 ];
		named: 'Package';
		order: 30.
	^ tmp2
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: RPackageOrganizer default packageNames ] ]
]
