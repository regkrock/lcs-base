Class {
	#name : 'LuiMenuItemExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiMenuItemExamples >> homeMenuItem [
	<gtExample>
	| item anchor |
	item := self newMenuItem.
	item buildFrom: LuiMenuItemDefinitionExamples new homeDefinition.
	self assert: item properties hasTitleProperty.
	self assert: item title equals: 'abc'.
	self assert: item isAnchor.
	anchor := item componentNamed: 'button'.
	self assert: (anchor isKindOf: LuiAnchor).
	self assert: anchor label equals: 'Home'.
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
