Extension { #name : #GtPharoTestCaseStateFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoTestCaseStateFilter class >> filterDescriptorFor: arg1 [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg2 | 
			| tmp4 |
			tmp4 := self new.
			tmp4
				resultStateString: arg2;
				pharoTestSuite: arg1 testSuite ];
		named: 'Tests';
		order: 13;
		completion: [ GtStringsCompletionStrategy new
					completions: [ GtPrefixTree withAll: GtPharoMethodTestCaseState allLabels ] ];
		emptyDefaultValue: self defaultState label.
	^ tmp2 beNotDefault
]
