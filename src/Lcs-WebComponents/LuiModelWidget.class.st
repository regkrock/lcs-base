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
	^ self onSlot: aSlotDefinition model: nil
]

{ #category : 'instance creation' }
LuiModelWidget class >> onSlot: aSlotDefinition model: aModel [
	^ self new
		initializeOnSlot: aSlotDefinition model: aModel;
		yourself
]

{ #category : 'instance creation' }
LuiModelWidget >> componentNameBaseOn: aSlotDefinition [
	^ aSlotDefinition slotName
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

{ #category : 'instance creation' }
LuiModelWidget >> initializeOnSlot: aSlotDefinition model: aModel [
	self valueAccessor: (LuiSlotAccessor newOn: self).
	self valueAccessor slotDefinition: aSlotDefinition.
	self model: aModel.
	self componentName:  (self componentNameBaseOn: aSlotDefinition)
]

{ #category : 'instance creation' }
LuiModelWidget >> initializeOnSlot: aSlotDefinition model: aModel name: aComponentName [
	self valueAccessor: (LuiSlotAccessor newOn: self ).
	self model: aModel.
	self valueAccessor slotDefinition: aSlotDefinition.
	self componentName: aComponentName
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
