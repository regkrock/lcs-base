Class {
	#name : 'LuiPushButtonFunctionalTest',
	#superclass : 'LuiFunctionalTest',
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'initialize' }
LuiPushButtonFunctionalTest >> initialize [
	| button form myLabel|
	super initialize.
	self componentName: 'root'.
	self componentId: 'root'.
	self addComponent: (form := LuiMainForm new).
	button := LuiButton named: 'button'.
	form addComponent: button.
	button
		label: 'Hello';
		addCssClass: 'button';
		title: 'Hello Title'.
		
	button := LuiButton named: 'submit'.
	form addComponent: button.
	button
		label: 'Submit';
		title: 'Submit Title';
		addCssClass: 'button';
		callback: [ myLabel labelString: '---submit recieved---' ];
		beSubmitType.
		
	button := LuiSaveButton named: 'saveButton'.
	button callback: [ myLabel labelString: '---save with icon pushed ---' ].
	form addComponent: button.
	button := LuiCancelButton named: 'cancelButton'.
	button callback: [ myLabel labelString: '---cancel with icon pushed ---' ].
	form addComponent: button.
		
	myLabel := LuiLabel named: 'myLabel'.
	myLabel labelString: '---waiting----'.
	form addComponent: myLabel.
	^ self
]
