Class {
	#name : 'LuiExampleRoot',
	#superclass : 'LuiRoot',
	#category : 'Lcs-WebComponentsTests-Base',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Base'
}

{ #category : 'initialize' }
LuiExampleRoot class >> initialize [
	self registerApplication: 'luiExample'
]

{ #category : 'instance creation' }
LuiExampleRoot class >> new [
	^ self newWithHeaderWithNavBar
]

{ #category : 'instance creation' }
LuiExampleRoot class >> newWithAnchorComponent [
	^ self basicNew intializeWithAnchorComponent
]

{ #category : 'instance creation' }
LuiExampleRoot class >> newWithButtonComponent [
	^ self basicNew intializeWithButtonComponent
]

{ #category : 'instance creation' }
LuiExampleRoot class >> newWithComponent: aComponent [
	^ self basicNew 
		initializeWithComponent: aComponent;
		yourself
]

{ #category : 'instance creation' }
LuiExampleRoot class >> newWithHeaderWithNavBar [
	^ (self basicNew initializeWithHeaderWithNavBar)
		addComponent: (((LuiForm newWith: (LuiDomainPresenter named: 'abc'))
						cssClass: 'mainForm';
						yourself)
							addComponent: (
								(LuiDiv named: 'text') 
									text: 'Hello';
									styleString: 'border: solid';
									yourself));
		yourself
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
	super initialize
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
