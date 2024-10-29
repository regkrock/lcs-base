Class {
	#name : #LuiMenuItemTest,
	#superclass : #TestCase,
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #testing }
LuiMenuItemTest >> testCreation [
	| item anchor |
	item := LuiMenuItem new.
	item buildFrom: (
			LcsMenuItemDefinition new 
				menuItemLabel: 'Home';
				useAnchorButton;
				title: 'abc';
				yourself).
	self assert: item properties hasTitleProperty.
	self assert: item title = 'abc'.
	self assert: item useAnchorButton.
	anchor := item componentNamed: 'button'.
	self assert: anchor label = 'Home'.


]
