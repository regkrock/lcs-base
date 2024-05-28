Extension { #name : #GtPharoMethodsCoderView }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoMethodsCoderView >> gtMethodsFor: arg1 [
	<gtView>
	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp7 tmp9 |
	tmp1 := GtPharoStreamingMethodsCoder forFilter: filter.
	tmp7 := GtPharoStreamingMethodsCoderViewModel new streamingCodersModel: tmp1.
	tmp7 shouldExpandByDefault: false.
	tmp2 := tmp7 shouldHaveHeaderByDefault: true.
	tmp9 := arg1 explicit.
	tmp9
		title: 'Methods';
		priority: 10.
	tmp3 := tmp9
			stencil: [ GtPharoStreamingMethodsCoderElement new streamingCodersViewModel: tmp2 ].
	shouldHaveTestsRunner
		ifTrue: [ tmp4 := GtPharoTestSuiteViewModel new
					pharoTestSuite: (GtPharoTestSuite forStream: tmp1 itemsStream).
			tmp1 testSuite: tmp4 pharoTestSuite.
			tmp3
				actionStencil: [ GtPharoCoderUIUtility newTestsDropdownButtonForViewModel: tmp4 ] ].
	shouldHaveExamplesRunner
		ifTrue: [ tmp5 := GtPharoExampleSuiteViewModel new
					pharoExampleSuite: (GtPharoExampleSuite forStream: tmp1 itemsStream).
			tmp1 exampleSuite: tmp5 pharoExampleSuite.
			tmp3
				actionStencil: [ GtPharoCoderUIUtility newExamplesDropdownButtonForViewModel: tmp5 ] ].
	^ tmp3
]
