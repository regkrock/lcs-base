Class {
	#name : 'LuiHeadingExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiHeadingExamples >> level1HeadingWithText [
	<gtExample>
	| component |
	component := self newComponent.
	component text: 'Sample'.
	self assert: component hasTextDecoration.
	self assertRendered: component equals: '<h1 data-name="heading" data-StClass="LuiHeading">Sample</h1>'.
	^ component
]

{ #category : 'examples' }
LuiHeadingExamples >> level2HeadingWithText [
	<gtExample>
	| component |
	component := self newComponent.
	component text: 'Sample'.
	component headingLevel: 2.
	self assert: component headingLevel equals: 2.
	self assert: component hasTextDecoration.
	self assertRendered: component equals: '<h2 data-name="heading" data-StClass="LuiHeading">Sample</h2>'.
	^ component
]

{ #category : 'examples' }
LuiHeadingExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiHeading named: 'heading'.
	self assert: component components isEmpty.
	self assert: component parentComponent isNil.
	self deny: component hasTextDecoration.
	self assert: component attributes hasHeadingLevelAttribute.
	self assert: component attributes headingLevelAttribute class equals: LuiHeadingLevelAttribute.
	self assertRendered: component equals: '<h1 data-name="heading" data-StClass="LuiHeading"></h1>'.
	^ component
]
