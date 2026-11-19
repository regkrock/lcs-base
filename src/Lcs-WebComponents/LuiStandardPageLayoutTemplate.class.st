Class {
	#name : 'LuiStandardPageLayoutTemplate',
	#superclass : 'LuiPageLayoutTemplate',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'components - definition' }
LuiStandardPageLayoutTemplate >> brandComponentDefinition [
	^ LuiBrand newSeasBrand
]

{ #category : 'components - definition' }
LuiStandardPageLayoutTemplate >> hiddenResponsiveMenuToggleDefinition [
	^ (LuiResponsiveNavigationMenuCheckbox named: 'menuToggle')
		assignStaticId: 'menu-toggle';
		yourself
]

{ #category : 'components - definition' }
LuiStandardPageLayoutTemplate >> navigationBarComponentDefinition [
	| navigationBar |
	navigationBar := LuiNavigationBar new.
	navigationBar
		addComponent: self brandComponentDefinition;
		addComponent: self hiddenResponsiveMenuToggleDefinition;
		addComponent: self responsiveMenuToggleLabelDefinition;
		addComponent: self navigationMenuDefinition.
	^ navigationBar
]

{ #category : 'components - definition' }
LuiStandardPageLayoutTemplate >> navigationMenuDefinition [
	^ LuiNavigationMenu new
]

{ #category : 'components - definition' }
LuiStandardPageLayoutTemplate >> pageHeaderComponentDefinition [
	| pageHeader |
	pageHeader := LuiPageHeader new.
	pageHeader addComponent: self navigationBarComponentDefinition.
	^ pageHeader
]

{ #category : 'components - definition' }
LuiStandardPageLayoutTemplate >> responsiveMenuToggleLabelDefinition [
	^ (LuiLabel named: 'menuToggleLabel')
		for: 'menu-toggle';
		cssClass: 'menu-btn';
		text: self class hamburgerCodePointString;
		yourself
]
