Class {
	#name : 'LuiSelectOption',
	#superclass : 'LuiModelWidget',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'initialize' }
LuiSelectOption >> componentAttributesClass [
	^ LuiSelectOptionAttributes
]

{ #category : 'attributes' }
LuiSelectOption >> htmlTagValue [
	^ self attributes htmlTagValue
]

{ #category : 'attributes' }
LuiSelectOption >> htmlTagValue: aString [
	^ self attributes htmlTagValue: aString
]

{ #category : 'initialize' }
LuiSelectOption >> initializeNamed: aComponentName model: anObject [
		super initializeNamed: aComponentName model: anObject.
		self htmlTagValue: anObject.
		self text: anObject
]

{ #category : 'initialize' }
LuiSelectOption >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super
		initializeOnSlot: aSlotDefinition
		model: aModel
		componentName: aString.
	self valueAccessor readSelector: #yourself.
	self htmlTagValue: (
		self valueAccessor slotDefinition optionValueFor: self model).
	self text: (
		self valueAccessor slotDefinition optionDisplayStringFor: self model)
]

{ #category : 'rendering' }
LuiSelectOption >> isSelected [
	^ self parentComponent valueAccessor read = self model
]

{ #category : 'composition' }
LuiSelectOption >> postAddToParent [
	"self addDependentComponent: self parentComponent"
]

{ #category : 'rendering' }
LuiSelectOption >> renderComponentOn: html [
	html option
		addCommonAttributes: self;
		selected: self isSelected;
		with: [ html text: self text ]
]
