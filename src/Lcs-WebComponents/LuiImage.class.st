Class {
	#name : 'LuiImage',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Buttons',
	#package : 'Lcs-WebComponents',
	#tag : 'Buttons'
}

{ #category : 'instance creation' }
LuiImage class >> newFavicon [
	^ self new
		componentName: 'favicon';
		cssClass: 'logo';
		title: 'Seas Monmouth';
		altText: 'Seas logo';
		url: LcsFileLibrary /#faviconPng;
		yourself
]

{ #category : 'properties' }
LuiImage >> altText [
	^ self properties altText
]

{ #category : 'properties' }
LuiImage >> altText: aString [
	self properties altText: aString
]

{ #category : 'rendering' }
LuiImage >> renderComponentOn: html [
	html image
		addCommonProperties: self;
		with: [ self renderDetailsOn: html ]
]

{ #category : 'properties' }
LuiImage >> url [
	^ self properties url
]

{ #category : 'properties' }
LuiImage >> url: aString [
	self properties url: aString
]
