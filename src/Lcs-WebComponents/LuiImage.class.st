Class {
	#name : 'LuiImage',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Buttons',
	#package : 'Lcs-WebComponents',
	#tag : 'Buttons'
}

{ #category : 'instance creation' }
LuiImage class >> newFacebookIcon [
	^ self new
		componentName: 'favicon';
		removeAllCssClasses;
		title: 'Facebook';
		altText: 'Link to Seas Monmouth Facebook Page';
		url: LcsFileLibrary /#facebook32Png;
		yourself
]

{ #category : 'instance creation' }
LuiImage class >> newMeetupIcon [
	^ self new
		removeAllCssClasses;
		title: 'Meetup';
		altText: 'Link to Seas Monmouth Meetup Page';
		url: LcsFileLibrary /#meetup32Png;
		yourself
]

{ #category : 'instance creation' }
LuiImage class >> newMobileMenuIcon [
	^ self new
		componentName: 'hamburger';
		altText: 'Mobile menu button';
		url: LcsFileLibrary /#hamburgerMenu24Svg;
		yourself
]

{ #category : 'instance creation' }
LuiImage class >> seasMonmouthFavicon [
	^ self new
		componentName: 'favicon';
		cssClass: 'logoImage';
		title: 'Seas Monmouth';
		altText: 'Seas logo';
		url: LcsFileLibrary /#faviconPng;
		yourself
]

{ #category : 'properties' }
LuiImage >> altText [
	^ self attributes altText
]

{ #category : 'properties' }
LuiImage >> altText: aString [
	self attributes altText: aString
]

{ #category : 'initialize' }
LuiImage >> componentAttributesClass [
	^ LuiImageAttributes
]

{ #category : 'rendering' }
LuiImage >> renderComponentOn: html [
	html image
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html]
]

{ #category : 'properties' }
LuiImage >> url [
	^ self attributes url
]

{ #category : 'properties' }
LuiImage >> url: aString [
	self attributes url: aString
]
