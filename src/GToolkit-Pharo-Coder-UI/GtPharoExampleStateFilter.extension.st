Extension { #name : #GtPharoExampleStateFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoExampleStateFilter class >> filterDescriptorFor: arg1 [
	| tmp2 |
	tmp2 := GtFilterDescriptor new.
	tmp2
		creator: [ :arg2 | 
			| tmp4 |
			tmp4 := self new.
			tmp4
				resultStateString: arg2;
				pharoExampleSuite: arg1 exampleSuite ];
		named: 'Examples';
		order: 12;
		completion: [ GtStringsCompletionStrategy new
					completions: [ GtPrefixTree withAll: GtExampleState default allLabels ] ];
		emptyDefaultValue: self defaultState label.
	^ tmp2 beNotDefault
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoExampleStateFilter class >> globalFilterDescriptor [
	^ nil
]
