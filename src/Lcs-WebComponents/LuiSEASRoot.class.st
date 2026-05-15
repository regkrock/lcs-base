Class {
	#name : 'LuiSEASRoot',
	#superclass : 'LuiRoot',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constant' }
LuiSEASRoot class >> browserTabName [
	^ 'SEAS'
]

{ #category : 'initialize' }
LuiSEASRoot class >> initialize [
	(WAAdmin register: self asApplicationAt: 'seas')
		sessionClass: WAExpirySession
]

{ #category : 'constants' }
LuiSEASRoot >> applicationTitle [
	^ 'SEAS Monmouth'
]

{ #category : 'initialize' }
LuiSEASRoot >> initialize [
	super initialize.
	self initializeStandardLayout
]

{ #category : 'instance creation' }
LuiSEASRoot >> initializeStandardLayout [
	self addComponent: LuiPageHeader new.
	(self componentNamed: 'header')
		addComponent: LuiLogoImage newFavicon.
	"(self componentNamed: 'header')
		addComponent: (LuiNavigationBar named: 'navbar').
	((self componentNamed: 'header') componentNamed: 'navbar')
		addNavigationMenuBuiltFrom: LuiNavigationMenuDefinitionExamples new navigationMenuWithThreeMenuItemDefinitions."
	(self componentNamed: 'header')
		addNavigationMenuBuiltFrom: LuiNavigationMenuDefinitionExamples new
]

{ #category : 'updating' }
LuiSEASRoot >> updateRoot: aRoot [
	super updateRoot: aRoot.
	aRoot beHtml5.
	aRoot meta
		name: 'viewport';
		content: 'width=device-width, initial-scale=1.0'.
	aRoot title: self applicationTitle.
	aRoot stylesheet url: LcsFileLibrary / #resetCss.
	aRoot stylesheet url: LcsFileLibrary / #mainCss.
	aRoot link beShortcutIcon url: LcsFileLibrary / #faviconPng
]
