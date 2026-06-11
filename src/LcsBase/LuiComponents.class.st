Class {
	#name : 'LuiComponents',
	#superclass : 'LcsObject',
	#instVars : [
		'components',
		'parent',
		'componentKeys'
	],
	#category : 'LcsBase-Core',
	#package : 'LcsBase',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LuiComponents class >> on: aComponent [
	^ self new
		parent: aComponent;
		yourself
]

{ #category : 'components' }
LuiComponents >> _componentNamed: aTargetNames [
	| targetComponent |
	targetComponent := self components at: aTargetNames first ifAbsent: [ ^ nil].
	aTargetNames size = 1 ifTrue: [ ^targetComponent ].
	^ targetComponent _componentNamed: (aTargetNames copyFrom: 2 to: aTargetNames size)
]

{ #category : 'components' }
LuiComponents >> addComponent: aComponent [
	self addToComponents: aComponent 
]

{ #category : 'components' }
LuiComponents >> addToComponents: aComponent [ 
	aComponent parentComponent: self parent.
	self components at: aComponent componentName put: aComponent.
	self componentKeys add: aComponent componentName.
	self componentsDo: [ :each | each assignId ].
	^ aComponent
]

{ #category : 'accessing' }
LuiComponents >> componentKeys [
	^ componentKeys
]

{ #category : 'accessing' }
LuiComponents >> componentKeys: anObject [
	componentKeys := anObject
]

{ #category : 'components' }
LuiComponents >> componentNamed: aString [
	| targetNames |
	targetNames := aString substrings: { $/ }.
	^ self _componentNamed: targetNames
]

{ #category : 'accessing' }
LuiComponents >> components [
	^ components
]

{ #category : 'accessing' }
LuiComponents >> components: anObject [
	components := anObject
]

{ #category : 'components' }
LuiComponents >> componentsDo: aBlock [
	self orderedComponents do: [ :eachComponent | 
		aBlock value: eachComponent.
		eachComponent componentsDo: aBlock ]
]

{ #category : 'initialize' }
LuiComponents >> initialize [
	super initialize.
	self components: Dictionary new.
	self componentKeys: OrderedCollection new
]

{ #category : 'components' }
LuiComponents >> orderedComponents [
	^ self componentKeys collect: [ :eachKey | self components at: eachKey ]
]

{ #category : 'accessing' }
LuiComponents >> parent [
	^ parent
]

{ #category : 'accessing' }
LuiComponents >> parent: anObject [
	parent := anObject
]

{ #category : 'components' }
LuiComponents >> parentComponent [
	^ self parent
]

{ #category : 'rendering' }
LuiComponents >> renderComponentsOn: html [
	self componentsDo: [ :each | each renderComponentOn: html ].
]
