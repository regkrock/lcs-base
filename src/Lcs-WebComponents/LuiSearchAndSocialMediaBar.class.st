Class {
	#name : 'LuiSearchAndSocialMediaBar',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LuiSearchAndSocialMediaBar class >> newSearchAndLinks [
	^ self new
		initializeSearchAndLinks;
		yourself
]

{ #category : 'initialize' }
LuiSearchAndSocialMediaBar >> initializeSearchAndLinks [
	self componentName: 'searchAndSocial'.
	self cssClass: 'sm'.
	self addComponent: (LuiForm newWith: (LuiSearchBarPresenter named: 'searchBarPresenter')).
	self addComponent: LuiSocialMediaBar newSeasSocialMediaBar
]
