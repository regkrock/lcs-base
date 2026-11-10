Class {
	#name : 'LuiMainForm',
	#superclass : 'LuiForm',
	#instVars : [
		'switchableComponents',
		'currentSwitchableComponentName'
	],
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'components' }
LuiMainForm >> currentSwitchableComponent [
	^ self components at: self switchableComponentName ifAbsent: [ nil ]
]

{ #category : 'components' }
LuiMainForm >> currentSwitchableComponent: aComponent [
	self components at: self switchableComponentName put: aComponent.
	(self componentKeys includes: self switchableComponentName)
		ifFalse: [ self componentKeys add: self switchableComponentName ]
]

{ #category : 'components' }
LuiMainForm >> currentSwitchableComponentName [
	^ (self currentSwitchableComponent ifNil: [ ^ nil ]) componentName
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
	self switchableComponents: IdentitySet new
]

{ #category : 'components' }
LuiMainForm >> switchToComponent: aComponent [
	aComponent parentComponent ifNil: [
		self
			wireToParent: aComponent
			position: [ 
				self currentSwitchableComponent: aComponent.
				self switchableComponents add: aComponent ] ].
	self currentSwitchableComponent: aComponent	
]

{ #category : 'components' }
LuiMainForm >> switchableComponentName [
	^ 'currentSwitchableComponent'
]

{ #category : 'components' }
LuiMainForm >> switchableComponentNamed: acurrentSwitchableComponentName [
	^ self switchableComponents detect: [ :each | each componentName = acurrentSwitchableComponentName ] ifNone: [ nil ]
]

{ #category : 'accessing' }
LuiMainForm >> switchableComponents [
	^ switchableComponents
]

{ #category : 'accessing' }
LuiMainForm >> switchableComponents: anObject [
	switchableComponents := anObject
]
