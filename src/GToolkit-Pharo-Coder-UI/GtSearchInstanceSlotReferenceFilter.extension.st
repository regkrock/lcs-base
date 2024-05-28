Extension { #name : #GtSearchInstanceSlotReferenceFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInstanceSlotReferenceFilter class >> filterDescriptorFor: arg1 [
	| tmp2 |
	arg1 isForClass ifFalse: [ ^ nil ].
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg2 | self forClassAndSubclasses: arg1 classOrMetaClass andVariable: arg2 ];
		named: 'Slots';
		order: 25.
	^ tmp2
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: arg1 classOrMetaClass allInstVarNames ] ]
]
