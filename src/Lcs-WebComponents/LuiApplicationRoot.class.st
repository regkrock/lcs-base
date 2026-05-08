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

{ #category : 'constants' }
LuiApplicationRoot >> applicationTitle [
	^ 'SEAS Monmouth'
]

{ #category : 'rendering' }
LuiApplicationRoot >> renderBeforeSubcomponentsOn: html [
	html text: 'Hello World'
]

{ #category : 'updating' }
LuiApplicationRoot >> updateRoot: aRoot [
	super updateRoot: aRoot.
	aRoot title: self applicationTitle.
	aRoot stylesheet url: LcsFileLibrary / #mainCss.
	aRoot link beShortcutIcon url: LcsFileLibrary / #faviconPng
]
