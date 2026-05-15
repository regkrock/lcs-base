Class {
	#name : 'LuiExampleRootComponent',
	#superclass : 'LuiRoot',
	#category : 'Lcs-WebComponentsTests-Base',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Base'
}

{ #category : 'initialize' }
LuiExampleRootComponent class >> browserTabName [
	^ 'example'
]

{ #category : 'initialize' }
LuiExampleRootComponent class >> initialize [
	WAAdmin register: self asApplicationAt: self browserTabName
]

{ #category : 'setup' }
LuiExampleRootComponent >> addMainNavigationMenuTo: aMainMenu [
	aMainMenu buildFrom: self menuDefinition
]

{ #category : 'initialize' }
LuiExampleRootComponent >> initialize [
	| mainPage |
	super initialize.
	self componentName: 'root'.
	self componentId: 'root'.
	self addComponent: (mainPage := LuiMainPage named: 'mainPage').

	self addMainNavigationMenuTo: (mainPage componentNamed: 'navBar/navigation').
	(mainPage componentNamed: 'header/title') domainObject: 'LCS Example'.

]

{ #category : 'setup' }
LuiExampleRootComponent >> menuDefinition [
	^ LuiNavigationMenuDefinitionExamples new navigationMenuWith3Submenus
]

{ #category : 'updating' }
LuiExampleRootComponent >> updateRoot: aRoot [
	super updateRoot: aRoot.
	aRoot title: 'LCS Seaside Example'.
	aRoot stylesheet url: LcsExampleFileLibrary / #mainCss
]
