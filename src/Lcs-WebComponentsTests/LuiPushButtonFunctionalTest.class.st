Class {
	#name : #LuiPushButtonFunctionalTest,
	#superclass : #LuiFunctionalTest,
	#category : #'Lcs-WebComponentsTests-Functional'
}

{ #category : #initialize }
LuiPushButtonFunctionalTest >> initialize [
	| button |
	super initialize.
	self componentName: 'root'.
	self componentId: 'root'.
	
	button := LuiPushButton named: 'button' on: self.
	self addComponent: button.
	button
		label: 'Hello';
		title: 'Hello'.
		
	button := LuiPushButton named: 'submit' on: self.
	self addComponent: button.
	button
		label: 'Submit';
		title: 'Submit';
		beSubmitType.
	^ self
]

{ #category : #'as yet unclassified' }
LuiPushButtonFunctionalTest >> renderComponentOn: html [
	super renderComponentOn: html
]

{ #category : #updating }
LuiPushButtonFunctionalTest >> updateRoot: aRoot [

	super updateRoot: aRoot.
	aRoot stylesheet url: LcsFunctionalTestFileLibrary / #mainCss
]
