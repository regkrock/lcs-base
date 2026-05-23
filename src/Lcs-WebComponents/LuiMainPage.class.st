Class {
	#name : 'LuiMainPage',
	#superclass : 'LuiPage',
	#instVars : [
		'pageTitle',
		'nextApplicationAreaClass',
		'swappedApplicationAreas',
		'currentApplicationAreaComponent'
	],
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'components' }
LuiMainPage >> applicationAreaComponent [
	^ self componentNamed: self applicationAreaComponentName
]

{ #category : 'component names' }
LuiMainPage >> applicationAreaComponentName [
	^ 'applicationArea'
]

{ #category : 'accessing' }
LuiMainPage >> currentApplicationAreaComponent [
	^ currentApplicationAreaComponent
]

{ #category : 'accessing' }
LuiMainPage >> currentApplicationAreaComponent: aComponent [
	currentApplicationAreaComponent := aComponent
]

{ #category : 'component class' }
LuiMainPage >> currentApplicationAreaComponentClass [
	^ self currentApplicationAreaComponent class
]

{ #category : 'component names' }
LuiMainPage >> currentApplicationAreaComponentName [
	^ self currentApplicationAreaComponent ifNil: [ nil ] ifNotNil: [ :component | component componentName ]
]

{ #category : 'initialize' }
LuiMainPage >> initialize [
	super initialize.
	self addComponent: (LuiPageHeader named: self headerComponentName).
	self headerComponent addComponent: (LuiPageTitle named: self titleComponentName).
	self addComponent: (LuiNavigationBar named: self navBarComponentName).
	self navBarComponent addComponent: (LuiMenu newMainMenuNamed: self navigationComponentName).
	self addComponent: (LuiHomeArea named: self applicationAreaComponentName).
	self swappedApplicationAreas: (LuiSwappedApplicationAreas named: 'swapArea')
]

{ #category : 'components' }
LuiMainPage >> navBarComponent [
	^ self componentNamed: self navBarComponentName
]

{ #category : 'component names' }
LuiMainPage >> navBarComponentName [
	^ 'navBar'
]

{ #category : 'components' }
LuiMainPage >> navigationComponent [
	^ self navBarComponent navigationComponent
]

{ #category : 'component names' }
LuiMainPage >> navigationComponentName [
	^ 'navigation'
]

{ #category : 'accessing' }
LuiMainPage >> nextApplicationAreaClass [
	^ nextApplicationAreaClass
]

{ #category : 'accessing' }
LuiMainPage >> nextApplicationAreaClass: anObject [
	nextApplicationAreaClass := anObject
]

{ #category : 'accessing' }
LuiMainPage >> pageTitle [
	^ pageTitle
]

{ #category : 'accessing' }
LuiMainPage >> pageTitle: anObject [
	pageTitle := anObject
]

{ #category : 'components' }
LuiMainPage >> pageTitleComponent [
	^ self headerComponent titleComponent
]

{ #category : 'rendering' }
LuiMainPage >> renderSubcomponentsOn: html [
	self setCurrentApplicatonAreaComponent.
	self nextApplicationAreaClass notNil
		ifTrue: [ self swapToNewApplicationAreaComponent ].
	super renderSubcomponentsOn: html.
	self setCurrentApplicatonAreaComponent
]

{ #category : 'rendering' }
LuiMainPage >> setCurrentApplicatonAreaComponent [
	self currentApplicationAreaComponent isNil
		ifTrue: [ self currentApplicationAreaComponent: self applicationAreaComponent ]
]

{ #category : 'building' }
LuiMainPage >> swapToNewApplicationAreaComponent [
	| currentComponent |
	currentComponent := self removeComponentNamed: self applicationAreaComponentName.
	self swappedApplicationAreas swappedOut: currentComponent.
	self addComponent: (
		self nextApplicationAreaClass named: self applicationAreaComponentName).
	self nextApplicationAreaClass: nil
]

{ #category : 'accessing' }
LuiMainPage >> swappedApplicationAreas [
	^ swappedApplicationAreas
]

{ #category : 'accessing' }
LuiMainPage >> swappedApplicationAreas: anObject [
	swappedApplicationAreas := anObject
]

{ #category : 'component names' }
LuiMainPage >> titleComponentName [
	^ 'title'
]
