Class {
	#name : 'LuiAnchorMenuItemFunctionalTest',
	#superclass : 'LuiFunctionalTest',
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'initialize' }
LuiAnchorMenuItemFunctionalTest >> initialize [
	| item |
	super initialize.
	self componentName: 'root'.
	self componentId: 'root'.
	
	item := LuiMenuItem named: 'menuItem'.
	self addComponent: item.
	item buildFrom: (
			LuiMenuItemDefinition new 
				label: 'Home(Anchor)';
				beAnchor;
				"onClickAction: #showLabelOnTranscript;"
				title: 'Home hover text';
				yourself).
	^ self
]
