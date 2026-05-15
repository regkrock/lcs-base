Class {
	#name : 'LuiLogoImage',
	#superclass : 'LuiImage',
	#category : 'Lcs-WebComponents-Buttons',
	#package : 'Lcs-WebComponents',
	#tag : 'Buttons'
}

{ #category : 'instance creation' }
LuiLogoImage class >> newFavicon [
	^ self new
		componentName: 'favicon';
		cssClass: 'logo';
		title: 'Seas Monmouth';
		altText: 'Seas logo';
		url: LcsFileLibrary /#faviconPng;
		yourself
]

{ #category : 'rendering' }
LuiLogoImage >> renderComponentOn: html [
	html div
		with: [ super renderComponentOn: html ]
]
