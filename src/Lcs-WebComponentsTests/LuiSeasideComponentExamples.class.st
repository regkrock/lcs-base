Class {
	#name : 'LuiSeasideComponentExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'private' }
LuiSeasideComponentExamples >> assert: aBlock gives: aString [
	| html |
	html := WAHtmlCanvas builder
		fullDocument: false;
		rootBlock: aBlock;
		render: aBlock.
	self assert: html equals: aString
]

{ #category : 'asserting' }
LuiSeasideComponentExamples >> assertRenderNewComponentEquals: aString [
	^ self assertRendered: self newComponent equals: aString
]

{ #category : 'asserting' }
LuiSeasideComponentExamples >> assertRendered: aComponent equals: aString [
	self
		assert: [ :html | html render: aComponent ]
		gives: aString.
	^ aString
]

{ #category : 'examples' }
LuiSeasideComponentExamples >> newComponent [
	self subclassResponsibility
]
