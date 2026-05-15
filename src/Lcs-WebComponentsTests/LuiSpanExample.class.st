Class {
	#name : 'LuiSpanExample',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiSpanExample >> newComponent [
	<gtExample>
	| component |
	component := LuiSpan named: 'mySpan'.
	self assertRendered: component equals: '<span name="mySpan" data-StClass="LuiSpan"></span>'.
	self deny: component hasTextDecoration.
	^ component
]

{ #category : 'examples' }
LuiSpanExample >> newComponentWithCssClass [
	<gtExample>
	| component |
	component := self newComponentWithText.
	component text: 'Span text'.
	self assert: component hasTextDecoration.
	self assert: component text equals: 'Span text'.
	component cssClass: 'menuItemTextClass'.
	self assert: component cssClassesString equals: 'menuItemTextClass'.
	self assertRendered: component equals: '<span name="mySpan" data-StClass="LuiSpan" class="menuItemTextClass">Span text</span>'.
	^ component
]

{ #category : 'examples' }
LuiSpanExample >> newComponentWithText [
	<gtExample>
	| component |
	component := self newComponent.
	component text: 'Span text'.
	self assert: component hasTextDecoration.
	self assert: component text equals: 'Span text'.
	self assertRendered: component equals: '<span name="mySpan" data-StClass="LuiSpan">Span text</span>'.
	^ component
]
