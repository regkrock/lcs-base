Class {
	#name : 'LuiExampleRoot',
	#superclass : 'LuiRoot',
	#category : 'Lcs-WebComponentsTests-Base',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Base'
}

{ #category : 'initialize' }
LuiExampleRoot class >> initialize [
	(WAAdmin register: self asApplicationAt: 'luiExample')
		sessionClass: WAExpirySession
]

{ #category : 'setup' }
LuiExampleRoot >> applicationTitle [
	^ 'Lui Example'
]

{ #category : 'initialize' }
LuiExampleRoot >> generatedId [
	^ 'root'
]

{ #category : 'initialize' }
LuiExampleRoot >> initialize [
	super initialize.
	self initializeStandardLayout
]

{ #category : 'initialize' }
LuiExampleRoot >> initializeStandardLayout [
	self addComponent: LuiDiv mobileMenuButton.
	self addComponent: LuiPageHeaderExamples new exampleHeader.
]

{ #category : 'updating' }
LuiExampleRoot >> updateFilesInRoot: aRoot [
	aRoot stylesheet url: LcsFileLibrary / #resetCss.
	aRoot stylesheet url: LcsFileLibrary / #mainCss.
	aRoot javascript url: LcsFileLibrary / #mobileNavJs.
	aRoot link beShortcutIcon url: LcsFileLibrary / #faviconPng
]
