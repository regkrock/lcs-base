Class {
	#name : 'LuiAnchorExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiAnchorExamples >> callbackExample [
	<gtExample>
	| component callbackBlock |
	callbackBlock := [ Transcript cr; show: 'anchor clicked'; cr ].
	component := self newComponent.
	component 
		text: 'Click For Callback';
		callback: callbackBlock.
	self assert: component callback == callbackBlock.
	self assert: component text equals: 'Click For Callback'.
	self assertRendered: component equals: '<a data-name="anchor" data-StClass="LuiAnchor" href="/?1">Click For Callback</a>'.
	^ component
]

{ #category : 'examples' }
LuiAnchorExamples >> callbackWithUrlExample [
	<gtExample>
	| component callbackBlock |
	callbackBlock := [ Transcript cr; show: 'anchor clicked'; cr ].
	component := self newComponent.
	component 
		text: 'Click For Callback';
		url: 'asdfasdf';
		callback: callbackBlock.
	self assert: component callback == callbackBlock.
	self assert: component text equals: 'Click For Callback'.
	self should: [self assertRendered: component equals: '<a data-name="anchor" data-StClass="LuiAnchor" href="/?1">Click For Callback</a>'] raise: Error description: 'Cannot have a callback and url together'.
	^ component
]

{ #category : 'examples' }
LuiAnchorExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiAnchor named: 'anchor'.
	self assert: component components isEmpty.
	self assert: component parentComponent isNil.
	self deny: component hasTextDecoration.
	self assertRendered: component equals: '<a data-name="anchor" data-StClass="LuiAnchor"></a>'.
	^ component
]

{ #category : 'examples' }
LuiAnchorExamples >> seasWebsiteImageLink [
	<gtExample>
	| component |
	component := self newComponent.
	component beBlankTarget. "Open on a new web browser tab"
	component url: 'https://www.sailseas.com/Monmouth/'.
	component addComponent: (
		(LuiImage named: 'image')
			url: LcsFileLibrary / #favicon;
			yourself).
	self assertRendered: component equals: '<a data-name="anchor" data-StClass="LuiAnchor" target="_blank" href="https://www.sailseas.com/Monmouth/"><img alt="" id="260556177" data-name="image" data-StClass="LuiImage" src="/files/LcsFileLibrary/favicon"/></a>'.
	^ component
]

{ #category : 'examples' }
LuiAnchorExamples >> seasWebsiteLink [
	<gtExample>
	| component |
	component := self newComponent.
	component text: 'SEAS'.
	self assert: component hasTextDecoration.
	component url: 'https://www.sailseas.com/Monmouth/'.
	self assert: component text equals: 'SEAS'.
	self assertRendered: component equals: '<a data-name="anchor" data-StClass="LuiAnchor" href="https://www.sailseas.com/Monmouth/">SEAS</a>'.
	^ component
]
