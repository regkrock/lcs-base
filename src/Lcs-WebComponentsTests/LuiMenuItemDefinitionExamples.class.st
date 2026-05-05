Class {
	#name : 'LuiMenuItemDefinitionExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiMenuItemDefinitionExamples >> homeMenuItemDefinition [
	<gtExample>
	| item |
	item := self newMenuItemDefinition.
	item
		menuItemLabel: 'Home';
		beAnchor;
		title: 'abc'.
	self assert: item title equals: 'abc'.
	self assert: item menuItemLabel equals: 'Home'.
	self assert: item isAnchor.
	^ item
]

{ #category : 'examples' }
LuiMenuItemDefinitionExamples >> newMenuItemDefinition [
	<gtExample>
	| item |
	item := LcsMenuItemDefinition new.
	self assert: item title isNil.
	self assert: item menuItemLabel isNil.
	self assert: item isPushButton.
	^ item
]
