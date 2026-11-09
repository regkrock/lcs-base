Class {
	#name : 'LuiMainForm',
	#superclass : 'LuiForm',
	#instVars : [
		'activeForms',
		'currentFormName'
	],
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'components' }
LuiMainForm >> activeFormNamed: aFormName [
	^ self activeForms detect: [ :each | each componentName = aFormName ] ifNone: [ nil ]
]

{ #category : 'accessing' }
LuiMainForm >> activeForms [
	^ activeForms
]

{ #category : 'accessing' }
LuiMainForm >> activeForms: anObject [
	activeForms := anObject
]

{ #category : 'components' }
LuiMainForm >> addForm: aComponent [ 
	aComponent parentComponent: self.
	aComponent postAddToParent.
	self activeForms add: aComponent.
	self componentsDo: [ :each | each assignId ].
	self componentsDo: [ :each | each assignInputIdToLabelForId ]
]

{ #category : 'components' }
LuiMainForm >> currentForm [
	^ self currentFormComponent currentForm
]

{ #category : 'components' }
LuiMainForm >> currentForm: aComponent [
	self currentFormComponent currentForm: aComponent.
	self currentFormName: aComponent componentName
]

{ #category : 'components' }
LuiMainForm >> currentFormComponent [
	^ self componentNamed: 'currentForm'
]

{ #category : 'accessing' }
LuiMainForm >> currentFormName [
	^ currentFormName
]

{ #category : 'accessing' }
LuiMainForm >> currentFormName: anObject [
	currentFormName := anObject
]

{ #category : 'defaults' }
LuiMainForm >> defaultComponentName [
	^ 'mainForm'
]

{ #category : 'defaults' }
LuiMainForm >> defaultCssClasses [
	^ OrderedCollection with: LuiCssClassesMap / #applicationArea
]

{ #category : 'initialize' }
LuiMainForm >> initialize [
	super initialize.
	self activeForms: IdentitySet new.
	self addComponent: (LuiCurrentFormComponent named: 'currentForm')
]

{ #category : 'rendering' }
LuiMainForm >> renderContentOn: html [
	super renderContentOn: html
]

{ #category : 'components' }
LuiMainForm >> switchToForm: aComponent [
	aComponent parentComponent ifNil: [
		self addForm: aComponent ].
	self currentForm: aComponent
]
