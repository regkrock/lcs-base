Class {
	#name : 'LuiMenuItemExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiMenuItemExamples >> homeMenuButtonItem [
	<gtExample>
	| item anchor |
	item := self newMenuItem.
	item buildFrom: LuiMenuItemDefinitionExamples new homeMenuItemDefinitionWithButton.
	self assert: item attributes hasTitleAttribute.
	self assert: item title equals: 'abc'.
	self assert: item isPushButton.
	anchor := item componentNamed: 'button'.
	self assert: (anchor isKindOf: LuiPushButton).
	self assert: anchor label equals: 'Home'.
	self assertRendered: item equals: '_'.
	^ item
]

{ #category : 'examples' }
LuiMenuItemExamples >> newMenuItem [
	<gtExample>
	| item |
	item := LuiMenuItem new.
	self deny: item isAnchor.
	self deny: item isPushButton.
	^ item
]
