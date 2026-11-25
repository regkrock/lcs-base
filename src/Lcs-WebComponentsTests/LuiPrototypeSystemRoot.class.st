Class {
	#name : 'LuiPrototypeSystemRoot',
	#superclass : 'LuiApplicationRoot',
	#category : 'Lcs-WebComponentsTests-Base',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Base'
}

{ #category : 'initialize' }
LuiPrototypeSystemRoot class >> initialize [
	self registerApplication: 'prototypeSystem'
]

{ #category : 'instance creation' }
LuiPrototypeSystemRoot class >> new [
	| systemApplicationRoot |
	systemApplicationRoot := super new.
	^ systemApplicationRoot
]

{ #category : 'defaults' }
LuiPrototypeSystemRoot >> applicationTitle [
	^ 'Prototype System'
]

{ #category : 'components - definition' }
LuiPrototypeSystemRoot >> currentSwitchableComponent [
	^ self mainForm currentSwitchableComponent
]

{ #category : 'defaults' }
LuiPrototypeSystemRoot >> generatedId [
	^ 'root'
]

{ #category : 'initialize' }
LuiPrototypeSystemRoot >> initialize [
	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.
	super initialize.
	LuiPrototypeStandardPageLayoutTemplate new buildLayoutFor: self.
	self currentSystem currentUser: self currentSystem guestuser.
	self assert: self currentUser equals: self currentSystem guestuser.
]

{ #category : 'components - querying' }
LuiPrototypeSystemRoot >> mainForm [
	^ self componentNamed: 'mainForm'
]

{ #category : 'components - querying' }
LuiPrototypeSystemRoot >> navigationBar [
	^ self pageHeader navigationBar
]

{ #category : 'components - querying' }
LuiPrototypeSystemRoot >> pageHeader [
	^ self componentNamed: 'pageHeader'
]

{ #category : 'components - definition' }
LuiPrototypeSystemRoot >> switchMainComponentTo: aComponent [
	self mainForm switchToComponent: aComponent
]

{ #category : 'updating' }
LuiPrototypeSystemRoot >> updateFilesInRoot: anHtmlRoot [
	| fileClass |
	fileClass := LcsPrototypeFileLibrary.
	super updateFilesInRoot: anHtmlRoot.
	anHtmlRoot stylesheet url: fileClass / #resetCss.
	LcsBaseFileLibrary addAllFilesIn: (FileSystem disk / 'Users/regkrock/SEAS/files').
	anHtmlRoot stylesheet url: fileClass / #mainCss.
	"anHtmlRoot stylesheet url: fileClass / #navigationMenuCss.
	anHtmlRoot stylesheet url: fileClass / #socialMediaCss."
	anHtmlRoot link beShortcutIcon url: fileClass / #faviconPng
]
