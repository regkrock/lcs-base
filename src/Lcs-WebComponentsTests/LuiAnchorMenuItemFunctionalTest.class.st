Class {
	#name : #LuiAnchorMenuItemFunctionalTest,
	#superclass : #LuiFunctionalTest,
	#category : #'Lcs-WebComponentsTests-Functional'
}

{ #category : #initialize }
LuiAnchorMenuItemFunctionalTest >> initialize [
	| item |
	super initialize.
	self componentName: 'root'.
	self componentId: 'root'.
	
	item := LuiMenuItem named: 'menuItem' on: self.
	self addComponent: item.
	item buildFrom: (
			LcsMenuItemDefinition new 
				menuItemLabel: 'Home(Anchor)';
				beAnchor;
				"onClickAction: #showLabelOnTranscript;"
				title: 'Home hover text';
				yourself).
	^ self
]

{ #category : #'as yet unclassified' }
LuiAnchorMenuItemFunctionalTest >> renderComponentOn: html [
	super renderComponentOn: html
]

{ #category : #updating }
LuiAnchorMenuItemFunctionalTest >> updateRoot: aRoot [

	super updateRoot: aRoot.
	aRoot stylesheet url: LcsFunctionalTestFileLibrary / #mainCss
]
