Class {
	#name : 'LuiExampleRoot',
	#superclass : 'LuiApplicationRoot',
	#category : 'Lcs-WebComponentsTests-Base',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Base'
}

{ #category : 'initialize' }
LuiExampleRoot class >> initialize [
	self registerApplication: 'luiExample'
]

{ #category : 'components' }
LuiExampleRoot >> anchorExample [
	^ (LuiAnchor named: 'anchor')
		text: 'OK Anchor';
		callback: [ self showCallbackOnTranscript ];
		yourself
]

{ #category : 'setup' }
LuiExampleRoot >> applicationTitle [
	^ 'Lui Example'
]

{ #category : 'setup' }
LuiExampleRoot >> generatedId [
	^ 'root'
]

{ #category : 'initialize' }
LuiExampleRoot >> initialize [
	super initialize.
	self initializeWithHeaderWithNavBar
		addComponent: (
			LuiMainForm new
				addComponent: (
					(LuiDomainPresenter named: 'abc')
						addComponent: (
							(LuiDiv named: 'text') 
								text: 'Hello';
								styleString: 'border: solid';
								yourself));
				yourself)
]

{ #category : 'initialize' }
LuiExampleRoot >> initializeWithComponent: aComponent [
	self initialize.
	self addComponent: aComponent
]

{ #category : 'initialize' }
LuiExampleRoot >> initializeWithHeaderWithNavBar [
	self initialize.
	self addComponent: LuiDiv mobileMenuButton.
	self addComponent: LuiPageHeaderExamples new exampleHeader.
]

{ #category : 'initialize' }
LuiExampleRoot >> intializeWithAnchorComponent [
	self
		initialize;
		addComponent: self anchorExample
]

{ #category : 'initialize' }
LuiExampleRoot >> intializeWithButtonComponent [
	self
		initialize;
		addComponent: self pushButtonExample
]

{ #category : 'components' }
LuiExampleRoot >> pushButtonExample [
	^ (LuiButton named: 'button')
		text: 'OK Button';
		styleString: 'border-style: solid; border-color: red;';
		callback: [ self showCallbackOnTranscript ];
		yourself
]

{ #category : 'callbacks' }
LuiExampleRoot >> showCallbackOnTranscript [
	Transcript
		cr;
		show: 'ok clicked';
		cr
]

{ #category : 'updating' }
LuiExampleRoot >> updateFilesInRoot: anHtmlRoot [
	| fileClass |
	fileClass := LcsExampleFileLibrary.
	super updateFilesInRoot: anHtmlRoot.
	anHtmlRoot stylesheet url: fileClass / #mainCss.
	anHtmlRoot link beShortcutIcon url: fileClass / #faviconPng
]
