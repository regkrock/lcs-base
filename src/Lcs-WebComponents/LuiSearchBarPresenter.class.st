Class {
	#name : 'LuiSearchBarPresenter',
	#superclass : 'LuiPresenter',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'initialize' }
LuiSearchBarPresenter >> initialize [
	super initialize.
	self addComponent: (
		(LuiTextInput named: 'search')
			placeholder: 'Search...';
			yourself).
	self addComponent: (
		(LuiPushButton named: 'searchButton')
			beSubmitType;
			leadingImageUrl: LcsFileLibrary / #searchSvg;
			leadingImageAltText: 'search button';
			yourself)
]

{ #category : 'rendering' }
LuiSearchBarPresenter >> renderComponentOn: html [
	self renderDetailsOn: html
]
