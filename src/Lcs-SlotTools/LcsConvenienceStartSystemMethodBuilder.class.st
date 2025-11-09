Class {
	#name : #LcsConvenienceStartSystemMethodBuilder,
	#superclass : #LcsMethodBuilder,
	#instVars : [
		'systemClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #initialize }
LcsConvenienceStartSystemMethodBuilder >> initialize [
	super initialize.
	self categoryName: #configuration
]

{ #category : #command }
LcsConvenienceStartSystemMethodBuilder >> methodSource [
	^'<1s>
	^ self createNewSystem: <2s>' expandMacrosWith: self selector with: self systemClassName
]

{ #category : #accessing }
LcsConvenienceStartSystemMethodBuilder >> systemClassName [
	^ systemClassName
]

{ #category : #accessing }
LcsConvenienceStartSystemMethodBuilder >> systemClassName: anObject [
	systemClassName := anObject
]
