Class {
	#name : 'LuiLabelWithInputComponent',
	#superclass : 'LuiModelWidget',
	#instVars : [
		'slotName',
		'widgetClass',
		'labelComponentName',
		'inputComponentName',
		'componentNamePrefix'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'instance creation' }
LuiLabelWithInputComponent class >> onSlot: aSlotDefinition [
	^ self onSlot: aSlotDefinition model: nil
]

{ #category : 'instance creation' }
LuiLabelWithInputComponent class >> onSlot: aSlotDefinition model: aModel [
	^ super new
		initializeOnSlot: aSlotDefinition model: aModel;
		yourself
]

{ #category : 'instance creation' }
LuiLabelWithInputComponent class >> onSlot: aSlotDefinition model: aModel widgetClass: aWidgetClass [
	^ super new
		initializeOnSlot: aSlotDefinition
			model: aModel
			widgetClass: aWidgetClass;
		yourself
]

{ #category : 'instance creation' }
LuiLabelWithInputComponent class >> onSlot: aSlotDefinition model: aModel widgetClass: aWidgetClass componentNamePrefix: aString [
	^ super new
		initializeOnSlot: aSlotDefinition
			model: aModel
			widgetClass: aWidgetClass
			componentNamePrefix: aString;
		yourself
]

{ #category : 'instance creation' }
LuiLabelWithInputComponent class >> onSlotNamed: aName model: aModel [
	^ super new
		initializeOnSlotName: aName model: aModel;
		yourself
]

{ #category : 'instance creation' }
LuiLabelWithInputComponent class >> onSlotNamed: aName model: aModel widgetClass: aWidgetClass [
	^ super new
		initializeOnSlotName: aName
			model: aModel
			widgetClass: aWidgetClass;
		yourself
]

{ #category : 'instance creation' }
LuiLabelWithInputComponent class >> onSlotNamed: aName model: aModel widgetClass: aWidgetClass componentNamePrefix: aString [
	^ super new
		initializeOnSlotName: aName
			model: aModel
			widgetClass: aWidgetClass
			componentNamePrefix: aString;
		yourself
]

{ #category : 'instance creation' }
LuiLabelWithInputComponent class >> onSlotNamed: aName model: aModel widgetClass: aWidgetClass componentPrefix: aString [
	^ super new
		initializeOnSlotName: aName
			model: aModel
			widgetClass: aWidgetClass
			componentPrefix: aString;
		yourself
]

{ #category : 'defualtos' }
LuiLabelWithInputComponent >> addCompoundInputComponent [
	self addComponent: (
		self widgetClass
			onSlot: self slotDefinition
			model: self model
			componentName: self inputComponentName)
]

{ #category : 'components' }
LuiLabelWithInputComponent >> addEmptyLabel [
	self addComponent: (LuiLabel named: self labelComponentName)
]

{ #category : 'components' }
LuiLabelWithInputComponent >> addEmptyLabelAndCompoundInputComponents [
	self labelComponentName: self componentNameLabelName. 
	self inputComponentName: self componentNameInputName.
	self addEmptyLabel.
	self addCompoundInputComponent
]

{ #category : 'components' }
LuiLabelWithInputComponent >> addLabelAndInputComponent [
	self labelComponentName: self componentNameLabelName. 
	self inputComponentName: self slotDefinition slotName.
	self addComponent: (LuiLabel onSlot: self slotDefinition model: self model).
	self addComponent: (self widgetClass onSlot: self slotDefinition model: self model)
]

{ #category : 'components' }
LuiLabelWithInputComponent >> addLabelAndInputComponents [
	| inputComponent |
	self labelComponentName: self slotNameLabel.
	self inputComponentName: self slotName.
	self
		addComponent: (LuiLabel
				onSlot: self slotDefinition
				model: self model
				componentName: self labelComponentName).
	inputComponent := self widgetClass
			onSlot: self slotDefinition
			model: self model
			componentName: self inputComponentName.
	self inputComponentName: inputComponent componentName.
	self addComponent: inputComponent
]

{ #category : 'components - updating' }
LuiLabelWithInputComponent >> assignInputIdToLabelForId [
	self labelComponent for: self inputComponent componentId
]

{ #category : 'private' }
LuiLabelWithInputComponent >> componentNameInputName [
	^ self componentName , 'Input'
]

{ #category : 'private' }
LuiLabelWithInputComponent >> componentNameLabelName [
	^ self componentName , 'Label'
]

{ #category : 'accessing' }
LuiLabelWithInputComponent >> componentNamePrefix [
	^ componentNamePrefix
]

{ #category : 'accessing' }
LuiLabelWithInputComponent >> componentNamePrefix: anObject [
	componentNamePrefix := anObject
]

{ #category : 'defualtos' }
LuiLabelWithInputComponent >> defaultCssClasses [
	^ OrderedCollection with: 'labelAndInputRow'
]

{ #category : 'testing' }
LuiLabelWithInputComponent >> hasInputComponent [
	^ (self componentNamed: self inputComponentName) notNil
]

{ #category : 'testing' }
LuiLabelWithInputComponent >> hasLabelComponent [
	^ (self componentNamed: self labelComponentName) notNil
]

{ #category : 'initialize' }
LuiLabelWithInputComponent >> initializeOnSlot: aSlotDefinition model: aModel [
	self
		initializeOnSlot: aSlotDefinition
		model: aModel
		widgetClass: aSlotDefinition defaultInputComponentClass
]

{ #category : 'initialize' }
LuiLabelWithInputComponent >> initializeOnSlot: aSlotDefinition model: aModel widgetClass: aWidgetClass [
	self
		initializeOnSlot: aSlotDefinition
		model: aModel
		widgetClass: aWidgetClass
		componentNamePrefix: aSlotDefinition slotName
]

{ #category : 'initialize' }
LuiLabelWithInputComponent >> initializeOnSlot: aSlotDefinition model: aModel widgetClass: aWidgetClass componentNamePrefix: aString [
	self slotName: aSlotDefinition slotName.
	self componentNamePrefix: aString.
	self componentName: self componentNamePrefix , 'LabelAndInput'.
	self widgetClass: aWidgetClass.

	self initializeOnSlot: aSlotDefinition model: aModel componentName: self componentName.

	({LuiCheckboxAndLabel. LuiCheckboxAndLabel} includes: self widgetClass)
		ifTrue: [ self addEmptyLabelAndCompoundInputComponents ]
		ifFalse: [ self addLabelAndInputComponents ]
]

{ #category : 'initialize' }
LuiLabelWithInputComponent >> initializeOnSlotName: aSlotName model: aModel [
	self
		initializeOnSlot: (aModel slotDefinitionNamed: aSlotName)
		model: aModel
]

{ #category : 'initialize' }
LuiLabelWithInputComponent >> initializeOnSlotName: aSlotName model: aModel widgetClass: aWidgetClass [ 
	self
		initializeOnSlot: (aModel slotDefinitionNamed: aSlotName)
		model: aModel
		widgetClass: aWidgetClass
		componentNamePrefix: aSlotName
]

{ #category : 'initializae' }
LuiLabelWithInputComponent >> initializeOnSlotName: aSlotName model: aModel widgetClass: aWidgetClass componentNamePrefix: aString [
	self
		initializeOnSlot: (aModel slotDefinitionNamed: aSlotName)
		model: aModel
		widgetClass: aWidgetClass
		componentNamePrefix: aString
]

{ #category : 'components' }
LuiLabelWithInputComponent >> inputComponent [
	^ self componentNamed: self inputComponentName
]

{ #category : 'accessing' }
LuiLabelWithInputComponent >> inputComponentName [
	^ inputComponentName
]

{ #category : 'accessing' }
LuiLabelWithInputComponent >> inputComponentName: anObject [
	inputComponentName := anObject
]

{ #category : 'components' }
LuiLabelWithInputComponent >> labelComponent [
	^ self componentNamed: self labelComponentName
]

{ #category : 'accessing' }
LuiLabelWithInputComponent >> labelComponentName [
	^ labelComponentName
]

{ #category : 'accessing' }
LuiLabelWithInputComponent >> labelComponentName: anObject [
	labelComponentName := anObject
]

{ #category : 'accessing' }
LuiLabelWithInputComponent >> slotDefinition [
	^ self valueAccessor slotDefinition
]

{ #category : 'accessing' }
LuiLabelWithInputComponent >> slotName [
	^ slotName
]

{ #category : 'accessing' }
LuiLabelWithInputComponent >> slotName: anObject [
	slotName := anObject
]

{ #category : 'private' }
LuiLabelWithInputComponent >> slotNameLabel [
	^ self slotName , 'Label'
]

{ #category : 'accessing' }
LuiLabelWithInputComponent >> widgetClass [
	^ widgetClass
]

{ #category : 'accessing' }
LuiLabelWithInputComponent >> widgetClass: anObject [
	widgetClass := anObject
]
