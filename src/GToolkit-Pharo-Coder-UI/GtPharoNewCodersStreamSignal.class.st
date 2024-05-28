Class {
	#name : #GtPharoNewCodersStreamSignal,
	#superclass : #GtPharoExampleSuiteMediatorSignal,
	#instVars : [
		'stream'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #printing }
GtPharoNewCodersStreamSignal >> printOneLineContentsOn: arg1 [
	self printOneLineCommunicatorId: arg1
]

{ #category : #accessing }
GtPharoNewCodersStreamSignal >> stream [
	^ stream
]

{ #category : #accessing }
GtPharoNewCodersStreamSignal >> stream: arg1 [
	stream := arg1
]
