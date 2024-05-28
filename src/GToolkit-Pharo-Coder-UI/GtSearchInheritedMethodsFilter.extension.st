Extension { #name : #GtSearchInheritedMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInheritedMethodsFilter class >> filterDescriptorFor: arg1 [
	| tmp1 tmp3 |
	arg1 isForClass ifFalse: [ ^ nil ].
	tmp1 := arg1 classOrMetaClass.
	tmp3 := GtFilterDescriptor new.
	tmp3
		creator: [ :arg2 | 
			| tmp4 |
			tmp4 := Smalltalk at: arg2 asSymbol ifAbsent: [ tmp1 ].
			(tmp1 withAllSuperclasses includes: tmp4) ifFalse: [ tmp4 := tmp1 ].
			(self forClass: tmp1) withSuperclassesUpTo: tmp4 ];
		named: 'Methods up to';
		order: 16;
		completion: [ GtStringsCompletionStrategy new
					completions: [ GtPrefixTree withAll: (tmp1 withAllSuperclasses collect: #name) ] ];
		emptyDefaultValue: tmp1 name.
	^ tmp3 beNotDefault
]
