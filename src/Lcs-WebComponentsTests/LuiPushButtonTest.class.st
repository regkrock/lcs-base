Class {
	#name : #LuiPushButtonTest,
	#superclass : #TestCase,
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #'as yet unclassified' }
LuiPushButtonTest >> testButtonWithNoLabelDefined [
	| button |
	button := LuiButton named: 'button' on: nil.
	self assert: button components isEmpty.
	self assert: button parentComponent isNil.
	self assert: button labelString isEmpty
]
