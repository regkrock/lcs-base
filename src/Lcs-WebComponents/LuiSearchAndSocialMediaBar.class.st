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
	self 
		componentName: 'searchAndSocial';
		cssClass: 'sm';
		addComponent: self searchFromComponentDefinition;
		addComponent: LuiSocialMediaBar newSeasSocialMediaBar
]

{ #category : 'initialize' }
LuiSearchAndSocialMediaBar >> searchFromComponentDefinition [
	^ LuiForm new
		addComponent: (LuiSearchBarPresenter named: 'searchBarPresenter');
		yourself

]
