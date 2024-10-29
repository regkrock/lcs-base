Class {
	#name : #LuiButtonMenuItemFunctionalTest,
	#superclass : #LuiFunctionalTest,
	#category : #'Lcs-WebComponentsTests-Functional'
}

{ #category : #initialize }
LuiButtonMenuItemFunctionalTest >> initialize [
	| item |
	super initialize.
	self componentName: 'root'.
	self componentId: 'root'.
	
	item := LuiMenuItem named: 'menuItem' on: self.
	self addComponent: item.
	item buildFrom: (
			LcsMenuItemDefinition new 
				menuItemLabel: 'Home(Button)';
				"onClick: #showLabelOnTranscript;"
				usePushButton;
				title: 'abc';
				yourself).
	^ self
]

{ #category : #'as yet unclassified' }
LuiButtonMenuItemFunctionalTest >> renderComponentOn: html [
	super renderComponentOn: html
]

{ #category : #updating }
LuiButtonMenuItemFunctionalTest >> updateRoot: aRoot [

	super updateRoot: aRoot.
	aRoot stylesheet url: LcsFunctionalTestFileLibrary / #mainCss
]
