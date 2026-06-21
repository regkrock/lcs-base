Class {
	#name : 'LuiPageHeader',
	#superclass : 'LuiComponent',
	#instVars : [
		'level'
	],
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'defaults' }
LuiPageHeader >> addNavigationMenuBuiltFrom: aNavigationMenuDefinition [
	| component |
	component := LuiMenu newMainMenuNamed: 'navigation'.
	self addComponent: component.
	component addNavigationMenuBuiltFrom: (LuiNavigationMenuDefinitionExamples new navigationMenuWithThreeMenuItemDefinitions).
	^ component
]

{ #category : 'defaults' }
LuiPageHeader >> beStandardPageHeader [
	self organizationLogoComponent.
	self pageTitleComponent.
	self loginButtonBar.
]

{ #category : 'defaults' }
LuiPageHeader >> defaultCssClasses [
	^ OrderedCollection with: 'pageHeader'
]

{ #category : 'inititalize' }
LuiPageHeader >> initialize [
	super initialize.
	self componentName: 'header'
]

{ #category : 'defaults' }
LuiPageHeader >> loginButtonBar [
	^ self
		componentNamed: self loginButtonBarComponentName
		ifNil: [ self addComponent: (LuiButtonBar named: self loginButtonBarComponentName) ]
]

{ #category : 'defaults' }
LuiPageHeader >> loginButtonBarComponentName [
	^ 'loginButtonBar'
]

{ #category : 'defaults' }
LuiPageHeader >> organizationLogoComponent [
	^ self
		componentNamed: self organizationLogoComponentName
		ifNil: [ self addComponent: (LuiObsoleteButton named: self organizationLogoComponentName) ]
]

{ #category : 'defaults' }
LuiPageHeader >> organizationLogoComponentName [
	^ 'organizationLogo'
]

{ #category : 'updating' }
LuiPageHeader >> pageTitle: aString [
	self pageTitleComponent text: aString
]

{ #category : 'defaults' }
LuiPageHeader >> pageTitleComponent [
	^ self
		componentNamed: self pageTitleComponentName
		ifNil: [ self addComponent: (LuiPageTitle named: self pageTitleComponentName) ]
]

{ #category : 'defaults' }
LuiPageHeader >> pageTitleComponentName [
	^ 'pageTitle'
]

{ #category : 'rendering' }
LuiPageHeader >> renderComponentOn: html [
	html header
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]
