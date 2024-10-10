Class {
	#name : #LuiMainPage,
	#superclass : #LuiPage,
	#instVars : [
		'pageTitle',
		'currentAreaComponent',
		'nextApplicationAreaClass',
		'swappedApplicationAreas'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #rendering }
LuiMainPage >> applicationAreaComponent [
	^ self componentNamed: self applicationAreaName
]

{ #category : #building }
LuiMainPage >> applicationAreaName [
	^ 'applicationArea'
]

{ #category : #components }
LuiMainPage >> currentAreaClass [
	^ self currentAreaComponent class
]

{ #category : #accessing }
LuiMainPage >> currentAreaComponent [
	^ currentAreaComponent
]

{ #category : #accessing }
LuiMainPage >> currentAreaComponent: aComponent [
	currentAreaComponent := aComponent
]

{ #category : #components }
LuiMainPage >> currentAreaComponentName [
	^ self currentAreaComponent ifNil: [ nil ] ifNotNil: [ :component | component componentName ]
]

{ #category : #building }
LuiMainPage >> homeApplicationAreaClass [
	^ LuiHomeArea
]

{ #category : #initialize }
LuiMainPage >> initialize [
	| header |
	super initialize.
	self addComponent: (header := LuiHeader named: 'header' on: self).
	header addComponent: (LuiHeading named: 'title' on: header).
	header addComponent: (LuiMainMenu named: 'navigation' on: header).	"self addComponent:  (LuiButtonBar named: 'actionBar' on: self)."
	self addComponent: (self homeApplicationAreaClass named: self applicationAreaName on: self).
	self swappedApplicationAreas: (LuiSwappedApplicationAreas on: self)
]

{ #category : #components }
LuiMainPage >> navigationBar [
	^ self componentNamed: 'header/navigation'
]

{ #category : #accessing }
LuiMainPage >> nextApplicationAreaClass [
	^ nextApplicationAreaClass
]

{ #category : #accessing }
LuiMainPage >> nextApplicationAreaClass: anObject [
	nextApplicationAreaClass := anObject
]

{ #category : #accessing }
LuiMainPage >> pageTitle [
	^ pageTitle
]

{ #category : #accessing }
LuiMainPage >> pageTitle: anObject [
	pageTitle := anObject
]

{ #category : #components }
LuiMainPage >> pageTitleComponent [
	^ self componentNamed: 'header/title'
]

{ #category : #rendering }
LuiMainPage >> renderSubcomponentsOn: html [
	self setCurrentApplicatonAreaComponent.
	self nextApplicationAreaClass notNil
		ifTrue: [ self swapToNewApplicationAreaComponent ].
	super renderSubcomponentsOn: html.
	self setCurrentApplicatonAreaComponent
]

{ #category : #rendering }
LuiMainPage >> setCurrentApplicatonAreaComponent [
	self currentAreaComponent isNil
		ifTrue: [ self currentAreaComponent: self applicationAreaComponent ]
]

{ #category : #building }
LuiMainPage >> swapToNewApplicationAreaComponent [
	| currentComponent |
	currentComponent := self removeComponentNamed: self applicationAreaName.
	self swappedApplicationAreas swappedOut: currentComponent.
	self addComponent: (
		self nextApplicationAreaClass named: self applicationAreaName on: self).
	self nextApplicationAreaClass: nil
]

{ #category : #accessing }
LuiMainPage >> swappedApplicationAreas [
	^ swappedApplicationAreas
]

{ #category : #accessing }
LuiMainPage >> swappedApplicationAreas: anObject [
	swappedApplicationAreas := anObject
]
