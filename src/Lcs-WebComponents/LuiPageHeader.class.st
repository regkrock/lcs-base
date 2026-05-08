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
	super initialize
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
		ifNil: [ self addComponent: (LuiAnchor named: self organizationLogoComponentName) ]
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
