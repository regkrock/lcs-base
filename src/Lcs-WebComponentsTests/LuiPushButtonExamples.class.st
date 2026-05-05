Class {
	#name : 'LuiPushButtonExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiPushButtonExamples >> newButton [
	<gtExample>
	| button |
	button := LuiPushButton named: 'button' on: nil.
	self assert: button components isEmpty.
	self assert: button parentComponent isNil.
	self deny: button hasLabelComponent.
	self assert: button labelString isEmpty.
	self assert: button properties buttonType equals: 'button'.
	self assert: button buttonTypeProperty propertyValue equals: 'button'.
	^ button
]

{ #category : 'examples' }
LuiPushButtonExamples >> okButton [
	<gtExample>
	| button |
	button := self newButton
				labelString: 'OK';
				yourself.
	self assert: button components size = 1.
	self assert: button hasLabelComponent.
	self assert: button labelString equals: 'OK'.
	^button
]

{ #category : 'examples' }
LuiPushButtonExamples >> okSubmitButton [
	<gtExample>
	| button |
	button := self okButton.
	button beSubmitType.
	self assert: button properties buttonType equals: 'submit'.
	^button
]
