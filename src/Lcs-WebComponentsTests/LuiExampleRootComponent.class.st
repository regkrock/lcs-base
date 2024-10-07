Class {
	#name : #LuiExampleRootComponent,
	#superclass : #LuiRoot,
	#category : #'Lcs-WebComponentsTests-Base'
}

{ #category : #initialize }
LuiExampleRootComponent class >> browserTabName [
	^ 'example'
]

{ #category : #initialize }
LuiExampleRootComponent class >> initialize [
	WAAdmin register: self asApplicationAt: self browserTabName
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
	| mainPage |
	super initialize.
	self componentName: 'root'.
	self componentId: 'root'.
	self addComponent: (mainPage := LuiMainPage named: 'mainPage' on: self).

	self addMainNavigationMenuTo: (mainPage componentNamed: 'header/navigation').
	(mainPage componentNamed: 'header/title') domainObject: 'LCS Example'.

]

{ #category : #setup }
LuiExampleRootComponent >> menuDefinition [
	^ LcsMainMenuDefinition menuBarWithSubSubMenuDefinition
]

{ #category : #rendering }
LuiExampleRootComponent >> renderComponentOn: html [
	html div 
		addCommonProperties: self;
		with: [
			self renderSubcomponentsOn: html ]
]

{ #category : #updating }
LuiExampleRootComponent >> updateRoot: aRoot [

	super updateRoot: aRoot.
	aRoot title: 'LCS Seaside Example'.
	aRoot stylesheet url: LcsFileLibrary / #mainCss
]
