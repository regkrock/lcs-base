Extension { #name : #GtSearchImplementorPatternFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchImplementorPatternFilter class >> filterDescriptorFor: arg1 [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg2 | self pattern: arg2 ];
		named: 'Implementor';
		order: 10.
	^ tmp2
		completion: [ GtStringsCompletionStrategy new completions: [ arg1 selectorNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchImplementorPatternFilter class >> globalFilterDescriptor [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg1 | self pattern: arg1 ];
		named: 'Implementor';
		order: 10.
	^ tmp2
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPharoIndex current selectorCache ] ]
]
