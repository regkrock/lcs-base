Extension { #name : #GtSearchClassSlotReferenceFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchClassSlotReferenceFilter class >> filterDescriptorFor: arg1 [
	| tmp2 |
	arg1 isForClass ifFalse: [ ^ nil ].
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg2 | self forClassAndSubclasses: arg1 classOrMetaClass classSide andVariable: arg2 ];
		named: 'Class slots';
		order: 27.
	^ tmp2
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: arg1 classOrMetaClass classSide allInstVarNames ] ]
]
