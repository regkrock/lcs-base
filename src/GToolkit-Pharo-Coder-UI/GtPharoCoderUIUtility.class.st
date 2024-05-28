Class {
	#name : #GtPharoCoderUIUtility,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> exampleViewModelCachedAs: arg1 inPhlowContext: arg2 [
	<return: #GtPharoExampleSuiteViewModel>
	^ arg2
		optionAt: arg1
		ifPresent: [ :arg3 | arg3 ]
		ifAbsentPut: [ | tmp1 tmp2 |
			tmp1 := GtPharoExampleSuite new.
			tmp2 := GtPharoExampleSuiteViewModel new pharoExampleSuite: tmp1.
			tmp2 ]
]

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> exampleViewModelCachedAs: arg1 inPhlowContext: arg2 forMethodsCoder: arg3 [
	<return: #GtPharoExampleSuiteViewModel>
	^ arg2
		optionAt: arg1
		ifPresent: [ :arg4 | 
			arg3 exampleSuite: arg4 pharoExampleSuite.
			arg4 ]
		ifAbsent: [ | tmp1 tmp2 |
			tmp1 := self exampleViewModelCachedAs: arg1 inPhlowContext: arg2.
			arg3 exampleSuite: tmp1 pharoExampleSuite.
			tmp2 := GtPharoExampleSuiteMethodsCoderMediator
					forMethodsCoder: arg3
					suiteModel: tmp1 pharoExampleSuite
					viewModel: tmp1.
			arg2 optionAt: arg1 , #_handler put: tmp2.
			tmp1 ]
]

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> filteredMethodsPhlowViewFor: arg1 context: arg2 filter: arg3 testsRunner: arg4 examplesRunner: arg5 [
	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 tmp7 tmp8 tmp9 tmp11 tmp13 |
	tmp1 := GtPharoStreamingMethodsCoder forFilter: arg3.
	tmp11 := GtPharoStreamingMethodsCoderViewModel new streamingCodersModel: tmp1.
	tmp11 shouldExpandByDefault: false.
	tmp2 := tmp11 shouldHaveHeaderByDefault: true.
	tmp13 := arg1 explicit.
	tmp13 title: 'Tests'.
	tmp3 := tmp13
			stencil: [ | tmp15 |
				tmp15 := GtPharoStreamingMethodsCoderElement new showIndicator.
				tmp15
					loadSinglesUntil: 20;
					streamingCodersViewModel: tmp2 ].
	arg4
		ifTrue: [ tmp4 := GtPharoTestSuite new.
			tmp1 testSuite: tmp4.
			tmp5 := GtPharoTestSuiteViewModel new pharoTestSuite: tmp4.
			tmp6 := GtPharoTestSuiteMethodsCoderMediator
					forMethodsCoder: tmp1
					suiteModel: tmp4
					viewModel: tmp5.
			arg2 optionAt: #testViewModelHandler put: tmp6.
			tmp3
				actionStencil: [ GtPharoCoderUIUtility newTestsDropdownButtonForViewModel: tmp5 ] ].
	arg5
		ifTrue: [ tmp7 := GtPharoExampleSuite new.
			tmp1 exampleSuite: tmp7.
			tmp8 := GtPharoExampleSuiteViewModel new pharoExampleSuite: tmp7.
			tmp9 := GtPharoExampleSuiteMethodsCoderMediator
					forMethodsCoder: tmp1
					suiteModel: tmp7
					viewModel: tmp8.
			arg2 optionAt: #exampleViewModelHandler put: tmp9.
			tmp3
				actionStencil: [ GtPharoCoderUIUtility newExamplesDropdownButtonForViewModel: tmp8 ] ].
	^ tmp3
]

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> newExamplesDropdownButtonForViewModel: arg1 [
	| tmp2 |
	tmp2 := GtPharoSuiteShowButton new.
	tmp2
		id: GtPharoExampleSuiteShowButtonId;
		label: 'Run Examples';
		suiteViewModel: arg1.
	^ tmp2 yourself
]

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> newTestsDropdownButtonForViewModel: arg1 [
	| tmp2 |
	tmp2 := GtPharoSuiteShowButton new.
	tmp2
		id: GtPharoTestSuiteShowButtonId;
		label: 'Run Tests';
		suiteViewModel: arg1.
	^ tmp2 yourself
]

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> testMethodsPhlowViewFor: arg1 context: arg2 filter: arg3 [
	^ self
		filteredMethodsPhlowViewFor: arg1
		context: arg2
		filter: arg3
		testsRunner: true
		examplesRunner: false
]
