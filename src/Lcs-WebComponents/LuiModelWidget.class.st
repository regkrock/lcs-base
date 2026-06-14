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
LuiModelWidget class >> named: aComponentName model: aModel [
	^ self new
		initializeNamed: aComponentName model: aModel;
		yourself
]

{ #category : 'instance creation' }
LuiModelWidget class >> named: aComponentName selector: aGetter model: aModel [
	^ self new
		initializeNamed: aComponentName selector: aGetter model: aModel;
		yourself
]

{ #category : 'instance creation' }
LuiModelWidget class >> onSlot: aSlotDefinition [
	^ self onSlot: aSlotDefinition model: nil
]

{ #category : 'instance creation' }
LuiModelWidget class >> onSlot: aSlotDefinition model: aModel [
	^ self
		onSlot: aSlotDefinition
		model: aModel
		componentName: aSlotDefinition slotName
]

{ #category : 'instance creation' }
LuiModelWidget class >> onSlot: aSlotDefinition model: aModel componentName: aString [
	^ self new
		initializeOnSlot: aSlotDefinition model: aModel componentName: aString;
		yourself
]

{ #category : 'instance creation' }
LuiModelWidget class >> onSlotNamed: aSlotName model: aModel [
	^ self onSlot: (aModel slotDefinitionNamed: aSlotName) model: aModel
]

{ #category : 'instance creation' }
LuiModelWidget class >> onSlotNamed: aSlotName model: aModel componentName: aString [
	^ self
		onSlot: (aModel slotDefinitionNamed: aSlotName)
		model: aModel
		componentName: aString
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
	self valueAccessor: (LuiSmalltalkObjectAccessor newOn: self )
]

{ #category : 'initialize' }
LuiModelWidget >> initializeNamed: aName  model: aModel [
	self initializeNamed: aName.
	self valueAccessor: (LuiSmalltalkObjectAccessor newOn: self  model: aModel)
]

{ #category : 'initialize' }
LuiModelWidget >> initializeNamed: aName selector: aGetter model: aModel [
	super initializeNamed: aName.
	self valueAccessor: (
		LuiSmalltalkObjectAccessor
			newOn: self
			selector: aGetter
			model: aModel)
]

{ #category : 'instance creation' }
LuiModelWidget >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	self valueAccessor: (
		LuiSlotAccessor
			newOn: self
			slotDefinition: aSlotDefinition
			model: aModel).
	self componentName: aString
]

{ #category : 'model' }
LuiModelWidget >> model [
	self valueAccessor model ifNotNil: [ : model | ^ model ].
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
