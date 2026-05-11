Class {
	#name : 'LuiApplicationRoot',
	#superclass : 'LuiRoot',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constant' }
LuiApplicationRoot class >> browserTabName [
	^ 'LCS Application'
]

{ #category : 'initialize' }
LuiApplicationRoot class >> initialize [
	(WAAdmin register: self asApplicationAt: 'lcsApplication')
		sessionClass: WAExpirySession
]

{ #category : 'instance creation' }
LuiApplicationRoot class >> newStandardLayout [
	^ self new
		initializeStandardLayout;
		yourself
]

{ #category : 'constants' }
LuiApplicationRoot >> applicationTitle [
	^ 'SEAS Monmouth'
]

{ #category : 'instance creation' }
LuiApplicationRoot >> initializeStandardLayout [
	self addComponent: LuiPageHeader new.
	(self componentNamed: 'header')
		addComponent: LuiImage newFavicon
]

{ #category : 'updating' }
LuiApplicationRoot >> updateRoot: aRoot [
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
