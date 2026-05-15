Class {
	#name : 'LuiTextDecorationExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiTextDecorationExamples >> newDecoration [
	<gtExample>
	| decoration |
	decoration := LuiTextDecoration new.
	self assert: decoration parent isNil.
	self assert: decoration decorationName equals: 'text'.
	self assert: decoration cachedValue isNil.
	^ decoration
]

{ #category : 'examples' }
LuiTextDecorationExamples >> textDecorationWithAbcText [
	<gtExample>
	| decoration |
	decoration := self newDecoration.
	decoration text: 'Abc'.
	self assert: decoration cachedValue equals: 'Abc'.
	self assert: decoration decorationValue equals: 'Abc'.
	self assert: decoration text equals: 'Abc'.
	^ decoration
]

{ #category : 'examples' }
LuiTextDecorationExamples >> textDecorationWithAbcTextAndChangeToDefText [
	<gtExample>
	| decoration |
	decoration := self textDecorationWithAbcText.
	decoration text: 'Def'.
	self assert: (decoration instVarNamed: 'cachedValue') isNil.
	self assert: decoration cachedValue equals: 'Def'.
	self assert: decoration decorationValue equals: 'Def'.
	self assert: decoration text equals: 'Def'.
	^ decoration
]
