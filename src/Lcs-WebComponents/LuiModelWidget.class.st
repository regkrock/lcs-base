Class {
	#name : 'LuiModelWidget',
	#superclass : 'LuiComponent',
	#instVars : [
		'valueAccessor'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'instance creation' }
LuiModelWidget class >> onSlot: aSlotDefinition [
	^ self new
		initializeOnSlot: aSlotDefinition;
		yourself
]

{ #category : 'rendering' }
LuiModelWidget >> displayValue [
	^ self valueAccessor displayValue
]

{ #category : 'initialize' }
LuiModelWidget >> initializeNamed: aName [
	super initializeNamed: aName.
	self valueAccessor: (LuiLocalAccessor newOn: self )
]

{ #category : 'initialize' }
LuiModelWidget >> initializeOnSlot: aSlotDefinition [
	self valueAccessor: (LuiSlotAccessor newOn: self ).
	self valueAccessor slotDefinition: aSlotDefinition.
	self componentName: aSlotDefinition slotName
]

{ #category : 'model' }
LuiModelWidget >> model [
	self valueAccessor _model ifNotNil: [ : model | ^ model ].
	^ self presenter ifNotNil: [ :presenter | presenter model ]
]

{ #category : 'model' }
LuiModelWidget >> model: aModel [
	self valueAccessor model: aModel.
]

{ #category : 'model' }
LuiModelWidget >> presenter [
	^ self myParentPresenterComponent
]

{ #category : 'accessing' }
LuiModelWidget >> valueAccessor [
	^ valueAccessor
]

{ #category : 'accessing' }
LuiModelWidget >> valueAccessor: anObject [
	valueAccessor := anObject
]
