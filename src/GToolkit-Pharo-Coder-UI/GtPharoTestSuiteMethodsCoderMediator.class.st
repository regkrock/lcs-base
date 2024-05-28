Class {
	#name : #GtPharoTestSuiteMethodsCoderMediator,
	#superclass : #GtPharoCommonSuiteMethodsCoderMediator,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #'private - streaming' }
GtPharoTestSuiteMethodsCoderMediator >> connect [
	| tmp1 tmp3 |
	tmp1 := self testCasesStream.
	tmp3 := GtPharoNewCodersStreamSignal new.
	tmp3
		mediator: self;
		stream: tmp1;
		emit.
	self suiteModel stream: tmp1
]

{ #category : #accessing }
GtPharoTestSuiteMethodsCoderMediator >> mediatorLabel [
	^ 'T'
]

{ #category : #'private - announcement handling' }
GtPharoTestSuiteMethodsCoderMediator >> onSuiteSelectedStateChanged: arg1 [
	| tmp2 |
	self methodsCoder ifNil: [ ^ self ].
	self suiteModel ifNil: [ ^ self ].
	tmp2 := GtPharoTestCaseStateFilter new.
	tmp2 resultState: arg1 state.
	self methodsCoder additionalFilters: (tmp2 pharoTestSuite: self suiteModel)
]

{ #category : #'private - streaming' }
GtPharoTestSuiteMethodsCoderMediator >> testCasesStream [
	^ (self subscriptionsStream map: [ :arg1 | arg1 testCase ])
		filter: [ :arg2 | arg2 isNotNil ]
]
