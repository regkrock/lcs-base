Class {
	#name : #GtPharoExampleSuiteMediatorSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'medator'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtPharoExampleSuiteMediatorSignal >> id [
	^ self mediator ifNotNil: #identityHash
]

{ #category : #accessing }
GtPharoExampleSuiteMediatorSignal >> mediator [
	^ medator
]

{ #category : #accessing }
GtPharoExampleSuiteMediatorSignal >> mediator: arg1 [
	medator := arg1
]

{ #category : #accessing }
GtPharoExampleSuiteMediatorSignal >> mediatorLabel [
	^ self mediator ifNil: [ '' ] ifNotNil: [ self mediator mediatorLabel ]
]

{ #category : #printing }
GtPharoExampleSuiteMediatorSignal >> printOneLineCommunicatorId: arg1 [
	self mediator ifNil: [ ^ self ].
	arg1
		nextPutAll: self mediatorLabel;
		nextPutAll: '-ID: ';
		print: self id
]
