Extension { #name : #GtSearchMethodsWithClassPatternFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithClassPatternFilter class >> filterDescriptorFor: arg1 [
	| tmp2 |
	arg1 isForClass ifTrue: [ ^ nil ].
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg2 | self pattern: arg2 ];
		named: 'Class';
		order: 20.
	^ tmp2
		completion: [ GtStringsCompletionStrategy new completions: [ arg1 classNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithClassPatternFilter class >> globalFilterDescriptor [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg1 | self pattern: arg1 ];
		named: 'Class';
		order: 20.
	^ tmp2
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPharoIndex current classNameTree ] ]
]
