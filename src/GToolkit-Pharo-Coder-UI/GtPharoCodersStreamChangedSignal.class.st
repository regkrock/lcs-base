Class {
	#name : #GtPharoCodersStreamChangedSignal,
	#superclass : #GtPharoExampleSuiteMediatorSignal,
	#instVars : [
		'announcement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtPharoCodersStreamChangedSignal >> announcement [
	^ announcement
]

{ #category : #accessing }
GtPharoCodersStreamChangedSignal >> announcement: arg1 [
	announcement := arg1
]

{ #category : #printing }
GtPharoCodersStreamChangedSignal >> printOneLineContentsOn: arg1 [
	self printOneLineCommunicatorId: arg1
]
