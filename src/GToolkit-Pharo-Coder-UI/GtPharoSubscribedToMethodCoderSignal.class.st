Class {
	#name : #GtPharoSubscribedToMethodCoderSignal,
	#superclass : #GtPharoExampleSuiteMediatorSignal,
	#instVars : [
		'methodCoder'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtPharoSubscribedToMethodCoderSignal >> methodCoder [
	^ methodCoder
]

{ #category : #accessing }
GtPharoSubscribedToMethodCoderSignal >> methodCoder: arg1 [
	methodCoder := arg1
]

{ #category : #printing }
GtPharoSubscribedToMethodCoderSignal >> printOneLineContentsOn: arg1 [
	| tmp1 |
	self printOneLineCommunicatorId: arg1.
	self methodCoder ifNil: [ ^ self ].
	self mediator ifNotNil: [ arg1 nextPutAll: ', ' ].
	(tmp1 := self methodCoder selector)
		ifNotNil: [ arg1 nextPutAll: tmp1 asString ]
]
