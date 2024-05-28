Extension { #name : #GtAsyncSearchMethodGroupStream }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtAsyncSearchMethodGroupStream >> asCoder [
	^ GtFilteredMethodsCoder forFilter: self filter
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtAsyncSearchMethodGroupStream >> gtItemsFor: arg1 [
	<gtView>
	| tmp2 |
	tmp2 := arg1 forward.
	tmp2
		title: 'Live' translated;
		priority: 10;
		object: [ self ].
	^ tmp2 view: #gtItemsFor:context:
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtAsyncSearchMethodGroupStream >> gtItemsFor: arg1 context: arg2 [
	<gtView>
	| tmp2 |
	tmp2 := GtPharoCoderUIUtility
			filteredMethodsPhlowViewFor: arg1
			context: arg2
			filter: filter
			testsRunner: true
			examplesRunner: true.
	tmp2 title: 'Live' translated.
	^ tmp2 priority: 10
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtAsyncSearchMethodGroupStream >> gtLiveFor: arg1 [
	<gtView>
	| tmp2 |
	tmp2 := arg1 columnedList.
	tmp2
		title: 'Methods' translated;
		priority: 11;
		column: 'Class' text: [ :arg2 | arg2 methodClass name ];
		column: 'Selector' text: [ :arg3 | arg3 selector ];
		column: 'Package' text: [ :arg4 | arg4 package name ].
	^ tmp2 items: [ self asyncSimilarCopy ]
]
