Class {
	#name : 'LuiApplication2Root',
	#superclass : 'LuiApplicationRoot',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'initialize' }
LuiApplication2Root class >> initialize [
	self registerApplication: 'lcsApplication2Root'
]

{ #category : 'constants' }
LuiApplication2Root >> applicationTitle [
	^ 'Lcs App'
]

{ #category : 'initialize' }
LuiApplication2Root >> initialize [
	super initialize.
	"self initializeStandardLayout"
]

{ #category : 'initialize' }
LuiApplication2Root >> initializeStandardLayout [
	self addComponent: LuiPageHeader new.
	(self componentNamed: 'header')
		addComponent: LuiImage seasMonmouthFavicon.
	(self componentNamed: 'header')
		addComponent: (LuiNavigationBar named: 'navbar').
	((self componentNamed: 'header') componentNamed: 'navbar')
		addNavigationMenuBuiltFrom: LuiNavigationMenuDefinitionExamples new navigationMenuWithThreeMenuItemDefinitions
]

{ #category : 'updating' }
LuiApplication2Root >> updateFilesInRoot: anHtmlRoot [ 
	| fileClass |
	fileClass := LcsFileLibrary.
	super updateFilesInRoot: anHtmlRoot.
	anHtmlRoot stylesheet url: fileClass / #resetCss.
	anHtmlRoot stylesheet url: fileClass / #mainCss.
	anHtmlRoot link beShortcutIcon url: fileClass / #faviconPng
]
