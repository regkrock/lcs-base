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

{ #category : 'rendering' }
LuiApplicationRoot >> renderComponentOn: html [
	super renderComponentOn: html.
	html text: 'Hello'
]
