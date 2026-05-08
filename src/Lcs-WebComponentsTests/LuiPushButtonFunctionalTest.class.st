Class {
	#name : 'LuiPushButtonFunctionalTest',
	#superclass : 'LuiFunctionalTest',
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'initialize' }
LuiPushButtonFunctionalTest >> initialize [
	| button |
	super initialize.
	self componentName: 'root'.
	self componentId: 'root'.
	
	button := LuiPushButton named: 'button' on: self.
	self addComponent: button.
	button
		label: 'Hello';
		addCssClass: 'button';
		title: 'Hello Title'.
		
	button := LuiPushButton named: 'submit' on: self.
	self addComponent: button.
	button
		label: 'Submit';
		title: 'Submit Title';
		addCssClass: 'button';
		beSubmitType.
	^ self
]

{ #category : 'updating' }
LuiPushButtonFunctionalTest >> updateRoot: aRoot [

	super updateRoot: aRoot.
	aRoot stylesheet url: LcsFunctionalTestFileLibrary / #mainCss
]
