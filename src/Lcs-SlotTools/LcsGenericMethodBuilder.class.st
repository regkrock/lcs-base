Class {
	#name : 'LcsGenericMethodBuilder',
	#superclass : 'LcsMethodBuilder',
	#instVars : [
		'methodSource'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'accessing' }
LcsGenericMethodBuilder >> methodSource [
	^ methodSource
]

{ #category : 'accessing' }
LcsGenericMethodBuilder >> methodSource: anObject [
	methodSource := anObject
]
