Class {
	#name : #LuiPushButtonTest,
	#superclass : #TestCase,
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #tests }
LuiPushButtonTest >> testButtonWithLabelDefined [
	| button |
	button := (LuiButton named: 'button' on: nil)
				labelString: 'OK';
				yourself.
	self assert: button components size = 1.
	self assert: button hasLabelComponent.
	self assert: button labelString equals: 'OK'
]

{ #category : #tests }
LuiPushButtonTest >> testCreation [
	| button |
	button := LuiButton named: 'button' on: nil.
	self assert: button components isEmpty.
	self assert: button parentComponent isNil.
	self deny: button hasLabelComponent.
	self assert: button labelString isEmpty
]
