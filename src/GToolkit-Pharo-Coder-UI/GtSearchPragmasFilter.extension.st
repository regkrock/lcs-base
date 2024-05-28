Extension { #name : #GtSearchPragmasFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchPragmasFilter class >> filterDescriptorFor: arg1 [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg2 | self forPragma: arg2 ];
		named: 'Pragma';
		order: 11.
	^ tmp2
		completion: [ GtStringsCompletionStrategy new completions: [ arg1 pragmaNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchPragmasFilter class >> globalFilterDescriptor [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg1 | self forPragma: arg1 ];
		named: 'Pragma';
		order: 11.
	^ tmp2
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: Pragma pragmaCache keys ] ]
]
