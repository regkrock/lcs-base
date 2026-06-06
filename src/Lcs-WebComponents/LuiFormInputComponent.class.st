Class {
	#name : 'LuiFormInputComponent',
	#superclass : 'LuiComponent',
	#instVars : [
		'valueAccessor'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'instance creation' }
LuiFormInputComponent class >> onSlot: aSlotDefinition [
	^ self new
		initializeOnSlot: aSlotDefinition;
		yourself
]

{ #category : 'initialize' }
LuiFormInputComponent >> componentAttributesClass [
	^ LuiFormInputAttributes
]

{ #category : 'rendering' }
LuiFormInputComponent >> displayValue [
	^ self valueAccessor displayValue
]

{ #category : 'initialize' }
LuiFormInputComponent >> initializeNamed: aName [
	super initializeNamed: aName.
	self name: aName.
	self valueAccessor: (LuiLocalAccessor newOn: self )
]

{ #category : 'initialize' }
LuiFormInputComponent >> initializeOnSlot: aSlotDefinition [
	self valueAccessor: (LuiSlotAccessor newOn: self ).
	self valueAccessor slotDefinition: aSlotDefinition.
	self componentName: aSlotDefinition slotName
]

{ #category : 'model' }
LuiFormInputComponent >> model [
	self valueAccessor _model ifNotNil: [ : model | ^ model ].
	^ self presenter ifNotNil: [ :presenter | presenter model ]
]

{ #category : 'as yet unclassified' }
LuiFormInputComponent >> model: aModel [
	self valueAccessor model: aModel.
]

{ #category : 'attributes' }
LuiFormInputComponent >> name [
	^ self attributes name
]

{ #category : 'attributes' }
LuiFormInputComponent >> name: aName [ 
	self attributes name: aName
]

{ #category : 'attributes' }
LuiFormInputComponent >> placeholder [
	^ self placeholderAttribute placeholder
]

{ #category : 'attributes' }
LuiFormInputComponent >> placeholder: aString [
	^ self placeholderAttribute placeholder: aString
]

{ #category : 'attributes' }
LuiFormInputComponent >> placeholderAttribute [
	^ self attributes placeholderAttribute
]

{ #category : 'model' }
LuiFormInputComponent >> presenter [
	^ self myParentPresenterComponent
]

{ #category : 'accessing' }
LuiFormInputComponent >> valueAccessor [
	^ valueAccessor
]

{ #category : 'accessing' }
LuiFormInputComponent >> valueAccessor: anObject [
	valueAccessor := anObject
]
