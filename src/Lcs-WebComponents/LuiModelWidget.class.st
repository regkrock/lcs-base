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

{ #category : 'testing' }
LuiModelWidget class >> isAbstract [ 
	^ self == LuiModelWidget
]

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

{ #category : 'attributes - accessing' }
LuiModelWidget >> callback [
	^ self attributes callback
]

{ #category : 'attributes - accessing' }
LuiModelWidget >> callback: aBlock [
	self attributes callback: aBlock 
]

{ #category : 'initialize' }
LuiModelWidget >> componentAttributesClass [
	^ LuiModelWidgetAttributes
]

{ #category : 'instance creation' }
LuiModelWidget >> componentNameBaseOn: aSlotDefinition [
	^ aSlotDefinition slotName
]

{ #category : 'rendering' }
LuiModelWidget >> displayValue [
	self valueAccessor ifNil: [ ^ 'nil' ].
	^ self valueAccessor displayValue
]

{ #category : 'callbacks' }
LuiModelWidget >> handleCallbackValue: value [ 
	self valueAccessor convertFromString: value
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
	aSlotDefinition isVirtualSlot ifTrue: [ self disabled: true ].
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

{ #category : 'callbacks' }
LuiModelWidget >> optionModel [
	^ self valueAccessor model
]

{ #category : 'model' }
LuiModelWidget >> presenter [
	^ self myParentPresenterComponent
]

{ #category : 'attributes - accessing' }
LuiModelWidget >> readOnly [
	^ self attributes readOnly
]

{ #category : 'attributes - accessing' }
LuiModelWidget >> readOnly: aBoolean [
	self attributes readOnly: aBoolean 
]

{ #category : 'accessing' }
LuiModelWidget >> valueAccessor [
	^ valueAccessor
]

{ #category : 'accessing' }
LuiModelWidget >> valueAccessor: anObject [
	valueAccessor := anObject
]
