Class {
	#name : 'LuiMenuItemDefinitionExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiMenuItemDefinitionExamples >> homeDefinition [
	<gtExample>
	| item |
	item := self newDefinition.
	item
		label: 'Home';
		beAnchor;
		title: 'abc'.
	self assert: item title equals: 'abc'.
	self assert: item label equals: 'Home'.
	self assert: item isAnchor.
	^ item
]

{ #category : 'examples' }
LuiMenuItemDefinitionExamples >> newDefinition [
	<gtExample>
	| item |
	item := LuiMenuItemDefinition new.
	self assert: item title isNil.
	self assert: item label isNil.
	self assert: item isPushButton.
	self assert: item cssClasses isEmpty.
	self assert: item parent isNil.
	^ item
]

{ #category : 'examples' }
LuiMenuItemDefinitionExamples >> newDefinitionWithLabel: aString [
	| item |
	item := self newDefinition.
	item label: aString.
	self assert: item label equals: aString.
	^ item
]
