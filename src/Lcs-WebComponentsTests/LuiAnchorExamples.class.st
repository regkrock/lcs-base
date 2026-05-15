Class {
	#name : 'LuiAnchorExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiAnchorExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiAnchor named: 'anchor'.
	self assert: component components isEmpty.
	self assert: component parentComponent isNil.
	self assert: component text isEmpty.
	self deny: component hasTextComponent.
	self assertRendered: component equals: '<a name="anchor" data-StClass="LuiAnchor"></a>'.
	^ component
]

{ #category : 'examples' }
LuiAnchorExamples >> seasWebsiteLink [
	<gtExample>
	| component |
	component := self newComponent.
	component text: 'SEAS'.
	component url: 'https://www.sailseas.com/Monmouth/'.
	self deny: component hasLabelComponent.
	self assert: component text equals: 'SEAS'.
	self assertRendered: component equals: '<a name="anchor" data-StClass="LuiAnchor" href="https://www.sailseas.com/Monmouth/">SEAS</a>'.
	^ component
]
