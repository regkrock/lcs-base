Class {
	#name : 'LcsComponentDecorationsExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsComponentDecorationsExamples >> componentDecorationsWithDependentComponentsDecoration [
	<gtExample>
	| componentDecorations |
	componentDecorations := self newComponentDecorations.
	self deny: componentDecorations hasDependentComponentsDecoration.
	componentDecorations addDependentComponent: 'abc'.
	self assert: componentDecorations hasDependentComponentsDecoration.
	self assert: componentDecorations dependentComponents size = 1.
	self assert: (componentDecorations dependentComponents includes: 'abc').
	componentDecorations removeDependentComponent: 'abc'.
	self assert: componentDecorations dependentComponents isEmpty.
	^ componentDecorations
]

{ #category : 'examples' }
LcsComponentDecorationsExamples >> componentDecorationsWithTextDecoration [
	<gtExample>
	| componentDecorations textDecoration|
	componentDecorations := self newComponentDecorations.
	componentDecorations text: 'abc'.
	self deny: componentDecorations hasNoDecorations.
	self assert: componentDecorations hasDecorations.
	textDecoration := componentDecorations decorationNamed: 'text'.
	self assert: textDecoration notNil.
	self assert: componentDecorations text equals: 'abc'.
	^ componentDecorations
]

{ #category : 'examples' }
LcsComponentDecorationsExamples >> newComponentDecorations [
	<gtExample>
	| componentDecorations |
	componentDecorations := LuiComponentDecorations new.
	self assert: componentDecorations collection isEmpty.
	self assert: componentDecorations hasNoDecorations.
	self deny: componentDecorations hasDecorations.
	self assert: (componentDecorations decorationNamed: 'xxx') isNil.
	^ componentDecorations
]
