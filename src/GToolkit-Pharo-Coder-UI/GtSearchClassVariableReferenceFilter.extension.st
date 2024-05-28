Extension { #name : #GtSearchClassVariableReferenceFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchClassVariableReferenceFilter class >> filterDescriptorFor: arg1 [
	| tmp2 |
	arg1 isForClass ifFalse: [ ^ nil ].
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg2 | self forClass: arg1 classOrMetaClass andVariable: arg2 ];
		named: 'Class variable';
		order: 26.
	^ tmp2
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: arg1 classOrMetaClass allClassVarNames ] ]
]
