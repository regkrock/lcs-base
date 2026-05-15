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
	
	button := LuiPushButton named: 'button'.
	self addComponent: button.
	button
		label: 'Hello';
		addCssClass: 'button';
		title: 'Hello Title'.
		
	button := LuiPushButton named: 'submit'.
	self addComponent: button.
	button
		label: 'Submit';
		title: 'Submit Title';
		addCssClass: 'button';
		beSubmitType.
	^ self
]
