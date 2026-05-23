Class {
	#name : 'LuiApplicationRoot',
	#superclass : 'LuiRoot',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'initialize' }
LuiApplicationRoot class >> initialize [
	(WAAdmin register: self asApplicationAt: 'lcsApplication')
		sessionClass: WAExpirySession
]

{ #category : 'constants' }
LuiApplicationRoot >> applicationTitle [
	^ 'Lcs App'
]

{ #category : 'initialize' }
LuiApplicationRoot >> initialize [
	super initialize.
	"self initializeStandardLayout"
]

{ #category : 'initialize' }
LuiApplicationRoot >> initializeStandardLayout [
	self addComponent: LuiPageHeader new.
	(self componentNamed: 'header')
		addComponent: LuiImage seasMonmouthFavicon.
	(self componentNamed: 'header')
		addComponent: (LuiNavigationBar named: 'navbar').
	((self componentNamed: 'header') componentNamed: 'navbar')
		addNavigationMenuBuiltFrom: LuiNavigationMenuDefinitionExamples new navigationMenuWithThreeMenuItemDefinitions
]

{ #category : 'updating' }
LuiApplicationRoot >> updateFilesInRoot: aRoot [ 
	aRoot stylesheet url: LcsFileLibrary / #resetCss.
	aRoot stylesheet url: LcsFileLibrary / #mainCss.
	aRoot link beShortcutIcon url: LcsFileLibrary / #faviconPng
]
