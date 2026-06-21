Class {
	#name : 'LuiFormExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiFormExamples >> formWithSearchImageAndInputField [
	<gtExample>
	| form |
	form := self newComponent.
	form addComponent: (
		(LuiTextInput named: 'search')
			placeholder: 'Search...';
			yourself).
	form addComponent: (
		(LuiButton named: 'searchButton')
			beSubmitType;
			leadingImageUrl: LcsFileLibrary / #search24Svg;
			leadingImageAltText: 'search button';
			yourself).
	self assert: (form componentNamed: 'search') notNil.
	self assert: (form componentNamed: 'searchButton') notNil.
	^ form
]

{ #category : 'examples' }
LuiFormExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiForm named: 'serchForm'.
	self assert: component componentName equals: 'serchForm'.
	self assert: component hasNoComponents.
	^ component
]
