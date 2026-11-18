Class {
	#name : 'LuiFunctionalTestsMainPage',
	#superclass : 'LuiComponent',
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
LuiFunctionalTestsMainPage >> applicationAreaComponent [
	^ self componentNamed: self applicationAreaComponentName
]

{ #category : 'component names' }
LuiFunctionalTestsMainPage >> applicationAreaComponentName [
	^ 'applicationArea'
]

{ #category : 'accessing' }
LuiFunctionalTestsMainPage >> currentApplicationAreaComponent [
	^ currentApplicationAreaComponent
]

{ #category : 'accessing' }
LuiFunctionalTestsMainPage >> currentApplicationAreaComponent: aComponent [
	currentApplicationAreaComponent := aComponent
]

{ #category : 'component class' }
LuiFunctionalTestsMainPage >> currentApplicationAreaComponentClass [
	^ self currentApplicationAreaComponent class
]

{ #category : 'component names' }
LuiFunctionalTestsMainPage >> currentApplicationAreaComponentName [
	^ self currentApplicationAreaComponent ifNil: [ nil ] ifNotNil: [ :component | component componentName ]
]

{ #category : 'component names' }
LuiFunctionalTestsMainPage >> headerComponentName [
	^ 'pageHeader'
]

{ #category : 'initialize' }
LuiFunctionalTestsMainPage >> initialize [
	super initialize.
	self componentName: 'mainPage'.
	self addComponent: LuiPageHeader new.
	self pageHeader addComponent: (LuiPageTitle named: self titleComponentName).
	self addComponent: LuiNavigationBar new.
	self navigationBar addComponent: LuiNavigationMenu new.
	self addComponent: (LuiHomeArea named: self applicationAreaComponentName).
	self swappedApplicationAreas: (LuiSwappedApplicationAreas named: 'swapArea')
]

{ #category : 'components' }
LuiFunctionalTestsMainPage >> navigationBar [
	^ self componentNamed: self navigationBarComponentName
]

{ #category : 'component names' }
LuiFunctionalTestsMainPage >> navigationBarComponentName [
	^ 'navbar'
]

{ #category : 'components' }
LuiFunctionalTestsMainPage >> navigationMenu [
	^ self navigationBar navigationMenu
]

{ #category : 'accessing' }
LuiFunctionalTestsMainPage >> nextApplicationAreaClass [
	^ nextApplicationAreaClass
]

{ #category : 'accessing' }
LuiFunctionalTestsMainPage >> nextApplicationAreaClass: anObject [
	nextApplicationAreaClass := anObject
]

{ #category : 'components' }
LuiFunctionalTestsMainPage >> pageHeader [
	^ self componentNamed: self headerComponentName
]

{ #category : 'accessing' }
LuiFunctionalTestsMainPage >> pageTitle [
	^ pageTitle
]

{ #category : 'accessing' }
LuiFunctionalTestsMainPage >> pageTitle: anObject [
	pageTitle := anObject
]

{ #category : 'components' }
LuiFunctionalTestsMainPage >> pageTitleComponent [
	^ self pageHeader pageTitleComponent
]

{ #category : 'rendering' }
LuiFunctionalTestsMainPage >> renderSubcomponentsOn: html [
	self setCurrentApplicatonAreaComponent.
	self nextApplicationAreaClass notNil
		ifTrue: [ self swapToNewApplicationAreaComponent ].
	super renderSubcomponentsOn: html.
	self setCurrentApplicatonAreaComponent
]

{ #category : 'rendering' }
LuiFunctionalTestsMainPage >> setCurrentApplicatonAreaComponent [
	self currentApplicationAreaComponent isNil
		ifTrue: [ self currentApplicationAreaComponent: self applicationAreaComponent ]
]

{ #category : 'building' }
LuiFunctionalTestsMainPage >> swapToNewApplicationAreaComponent [
	| currentComponent |
	currentComponent := self removeComponentNamed: self applicationAreaComponentName.
	self swappedApplicationAreas swappedOut: currentComponent.
	self addComponent: (
		self nextApplicationAreaClass named: self applicationAreaComponentName).
	self nextApplicationAreaClass: nil
]

{ #category : 'accessing' }
LuiFunctionalTestsMainPage >> swappedApplicationAreas [
	^ swappedApplicationAreas
]

{ #category : 'accessing' }
LuiFunctionalTestsMainPage >> swappedApplicationAreas: anObject [
	swappedApplicationAreas := anObject
]

{ #category : 'component names' }
LuiFunctionalTestsMainPage >> titleComponentName [
	^ 'title'
]
