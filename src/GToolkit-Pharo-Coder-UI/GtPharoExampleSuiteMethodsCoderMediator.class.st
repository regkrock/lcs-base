Class {
	#name : #GtPharoExampleSuiteMethodsCoderMediator,
	#superclass : #GtPharoCommonSuiteMethodsCoderMediator,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #'private - streaming' }
GtPharoExampleSuiteMethodsCoderMediator >> connect [
	| tmp1 tmp3 |
	tmp1 := self examplesStream.
	tmp3 := GtPharoNewCodersStreamSignal new.
	tmp3
		mediator: self;
		stream: tmp1;
		emit.
	self suiteModel stream: tmp1
]

{ #category : #'private - streaming' }
GtPharoExampleSuiteMethodsCoderMediator >> examplesStream [
	^ (self subscriptionsStream map: [ :arg1 | arg1 example ])
		filter: [ :arg2 | arg2 isNotNil ]
]

{ #category : #accessing }
GtPharoExampleSuiteMethodsCoderMediator >> mediatorLabel [
	^ 'E'
]

{ #category : #'private - announcement handling' }
GtPharoExampleSuiteMethodsCoderMediator >> onSuiteSelectedStateChanged: arg1 [
	| tmp2 tmp4 |
	self methodsCoder ifNil: [ ^ self ].
	self suiteModel ifNil: [ ^ self ].
	tmp2 := GtPharoMethodCoderAnnouncementSignal new.
	tmp2
		mediator: self;
		announcement: arg1;
		emit.
	tmp4 := GtPharoExampleStateFilter new.
	tmp4 resultState: arg1 state.
	self methodsCoder additionalFilters: (tmp4 pharoExampleSuite: self suiteModel)
]
