Class {
	#name : #LuiExampleRootComponent,
	#superclass : #LuiComponent,
	#category : #'Lcs-WebComponentsTests-Base'
}

{ #category : #initialize }
LuiExampleRootComponent class >> initialize [
	WAAdmin register: self asApplicationAt: 'example'
]

{ #category : #setup }
LuiExampleRootComponent >> addMainNavigationMenuTo: aComponent [
	| menuBarComponent |
	menuBarComponent := LuiMainMenu named: 'navigation' on: aComponent.
	aComponent addComponent: menuBarComponent.
	menuBarComponent buildFrom: self menuDefinition
]

{ #category : #initialize }
LuiExampleRootComponent >> initialize [
	super initialize.
	self addComponent: (LuiExampleMainPage named: 'mainPage' on: self).
	self addMainNavigationMenuTo: self lastComponent
]

{ #category : #setup }
LuiExampleRootComponent >> menuDefinition [
	^ LcsMainMenuDefinition menuBarWithSubSubMenuDefinition
]

{ #category : #rendering }
LuiExampleRootComponent >> renderComponentOn: html [
	html div 
		with: [
			html heading
				level: 1;
				with: 'LCS Example System'.
			html break.
			self renderSubcomponentsOn: html ]
]

{ #category : #updating }
LuiExampleRootComponent >> updateRoot: aRoot [

	super updateRoot: aRoot.
	aRoot title: 'LCS Seaside Example'.
	aRoot stylesheet url: LcsFileLibrary / #mainCss
]
