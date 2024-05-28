Class {
	#name : #GtPharoCommonSuiteMethodsCoderMediator,
	#superclass : #Object,
	#instVars : [
		'methodsCoder',
		'suiteModel',
		'suiteViewModel'
	],
	#classVars : [
		'CanSubscribeToMethodCoder'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #'api - settings' }
GtPharoCommonSuiteMethodsCoderMediator class >> canSubscribeToMethodCoder [
	^ CanSubscribeToMethodCoder = true
]

{ #category : #'api - settings' }
GtPharoCommonSuiteMethodsCoderMediator class >> disableSubscribeToMethodCoder [
	CanSubscribeToMethodCoder := false
]

{ #category : #'api - settings' }
GtPharoCommonSuiteMethodsCoderMediator class >> enableSubscribeToMethodCoder [
	CanSubscribeToMethodCoder := true
]

{ #category : #'api - instance creation' }
GtPharoCommonSuiteMethodsCoderMediator class >> forMethodsCoder: arg1 suiteModel: arg2 viewModel: arg3 [
	| tmp2 |
	tmp2 := self new.
	tmp2
		methodsCoder: arg1;
		suiteModel: arg2;
		suiteViewModel: arg3.
	^ tmp2 connect
]

{ #category : #'private - testing' }
GtPharoCommonSuiteMethodsCoderMediator >> canSubscribeToMethodCoder [
	^ self class canSubscribeToMethodCoder
]

{ #category : #'private - subscriptions' }
GtPharoCommonSuiteMethodsCoderMediator >> connect [
	self subclassResponsibility
]

{ #category : #accessing }
GtPharoCommonSuiteMethodsCoderMediator >> mediatorLabel [
	^ ''
]

{ #category : #accessing }
GtPharoCommonSuiteMethodsCoderMediator >> methodsCoder [
	^ methodsCoder
]

{ #category : #accessing }
GtPharoCommonSuiteMethodsCoderMediator >> methodsCoder: arg1 [
	self
		assert: [ methodsCoder isNil ]
		description: [ 'Methods coder can be initialized only once' ].
	methodsCoder := arg1.
	arg1
		when: GtStreamingCodersStreamChanged
		send: #onCodersStreamChanged:
		to: self
]

{ #category : #'private - announcement handling' }
GtPharoCommonSuiteMethodsCoderMediator >> onCoderMethodAdded: arg1 [
	| tmp2 |
	tmp2 := GtPharoMethodCoderAddedSignal new.
	tmp2
		mediator: self;
		announcement: arg1;
		emit.
	self connect
]

{ #category : #'private - announcement handling' }
GtPharoCommonSuiteMethodsCoderMediator >> onCoderMethodModified: arg1 [
	| tmp2 |
	tmp2 := GtPharoMethodCoderModifiedSignal new.
	tmp2
		mediator: self;
		announcement: arg1;
		emit.
	self connect
]

{ #category : #'private - announcement handling' }
GtPharoCommonSuiteMethodsCoderMediator >> onCoderMethodRemoved: arg1 [
	| tmp1 tmp3 |
	tmp3 := GtPharoMethodCoderRemovedSignal new.
	tmp3
		mediator: self;
		announcement: arg1;
		emit.
	(tmp1 := arg1 coder) ifNotNil: [ tmp1 unsubscribe: self ].
	self connect
]

{ #category : #'private - announcement handling' }
GtPharoCommonSuiteMethodsCoderMediator >> onCodersStreamChanged: arg1 [
	| tmp2 |
	self methodsCoder ifNil: [ ^ self ].
	self suiteModel ifNil: [ ^ self ].
	tmp2 := GtPharoCodersStreamChangedSignal new.
	tmp2
		mediator: self;
		announcement: arg1;
		emit.
	((arg1 isDueTo: GtStreamingCodersAddedReason)
		or: [ (arg1 isDueTo: GtStreamingCodersRemovedReason)
				or: [ arg1 isDueTo: GtStreamingCodersSwappedReason ] ]) ifFalse: [ ^ self ].
	self connect
]

{ #category : #'private - announcement handling' }
GtPharoCommonSuiteMethodsCoderMediator >> onPharoMethodCoderCompiled: arg1 [
	| tmp2 |
	tmp2 := GtPharoMethodCoderCompiledSignal new.
	tmp2
		mediator: self;
		announcement: arg1;
		emit.
	self connect
]

{ #category : #'private - announcement handling' }
GtPharoCommonSuiteMethodsCoderMediator >> onSuiteSelectedStateChanged: arg1 [
	self subclassResponsibility
]

{ #category : #'private - subscriptions' }
GtPharoCommonSuiteMethodsCoderMediator >> subscribeToMethodCoder: arg1 [
	| tmp2 |
	self canSubscribeToMethodCoder ifFalse: [ ^ self ].
	(arg1 announcer hasSubscriber: self) ifTrue: [ ^ self ].
	arg1 weak
		when: GtCoderMethodModified
			send: #onCoderMethodModified:
			to: self;
		when: GtPharoMethodCoderCompiled
			send: #onPharoMethodCoderCompiled:
			to: self.
	tmp2 := GtPharoSubscribedToMethodCoderSignal new.
	tmp2
		methodCoder: arg1;
		mediator: self;
		emit
]

{ #category : #'private - subscriptions' }
GtPharoCommonSuiteMethodsCoderMediator >> subscriptionsStream [
	^ self methodsCoder codersStream
		relay: [ :arg1 | self subscribeToMethodCoder: arg1 ]
]

{ #category : #accessing }
GtPharoCommonSuiteMethodsCoderMediator >> suiteModel [
	^ suiteModel
]

{ #category : #accessing }
GtPharoCommonSuiteMethodsCoderMediator >> suiteModel: arg1 [
	self
		assert: [ suiteModel isNil ]
		description: [ 'Suite model can be initialized only once' ].
	suiteModel := arg1
]

{ #category : #accessing }
GtPharoCommonSuiteMethodsCoderMediator >> suiteViewModel [
	^ suiteViewModel
]

{ #category : #accessing }
GtPharoCommonSuiteMethodsCoderMediator >> suiteViewModel: arg1 [
	self
		assert: [ suiteViewModel isNil ]
		description: [ 'Suite view model can be initialized only once' ].
	suiteViewModel := arg1.
	arg1
		when: GtPharoSuiteSelectedStateChanged
		send: #onSuiteSelectedStateChanged:
		to: self
]
