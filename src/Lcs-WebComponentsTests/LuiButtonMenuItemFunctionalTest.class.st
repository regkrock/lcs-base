Class {
	#name : 'LuiButtonMenuItemFunctionalTest',
	#superclass : 'LuiFunctionalTest',
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'initialize' }
LuiButtonMenuItemFunctionalTest >> initialize [
	| item |
	super initialize.
	self componentName: 'root'.
	self componentId: 'root'.
	
	item := LuiMenuItem named: 'menuItem' on: self.
	self addComponent: item.
	item buildFrom: (
			LuiMenuItemDefinition new 
				label: 'Home(Button)';
				"onClick: #showLabelOnTranscript;"
				bePushButton;
				title: 'abc';
				yourself).
	^ self
]

{ #category : 'updating' }
LuiButtonMenuItemFunctionalTest >> updateRoot: aRoot [

	super updateRoot: aRoot.
	aRoot stylesheet url: LcsFunctionalTestFileLibrary / #mainCss
]
