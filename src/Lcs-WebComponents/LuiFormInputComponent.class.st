Class {
	#name : 'LuiFormInputComponent',
	#superclass : 'LuiModelWidget',
	#instVars : [
		'codec'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'testing' }
LuiFormInputComponent class >> isAbstract [ 
	^ self == LuiFormInputComponent
]

{ #category : 'attributes - accessing' }
LuiFormInputComponent >> callback [
	^ self attributes callback 
]

{ #category : 'attributes - accessing' }
LuiFormInputComponent >> callback: aBlock [
	self attributes callback: aBlock 
]

{ #category : 'accessing' }
LuiFormInputComponent >> codec [
	^ codec
]

{ #category : 'accessing' }
LuiFormInputComponent >> codec: anObject [
	codec := anObject
]

{ #category : 'initialize' }
LuiFormInputComponent >> componentAttributesClass [
	^ LuiFormInputAttributes
]

{ #category : 'components' }
LuiFormInputComponent >> componentIdOf: aComponentName [
	^ (self myParentPresenterComponent componentNamed: aComponentName) componentId
]

{ #category : 'defaults' }
LuiFormInputComponent >> defaultCssClasses [
	^OrderedCollection with: LuiCssClassesMap | #inputField
]

{ #category : 'rendering' }
LuiFormInputComponent >> displayValue [
	| string |
	self valueAccessor ifNil: [ ^ '' ].
	(self cssClasses includes: 'inputFieldError')
		ifTrue: [ string := self valueAccessor candidateValue ]
		ifFalse: [ string := self codec encode: valueAccessor read ].
	^ string
]

{ #category : 'gt views' }
LuiFormInputComponent >> gtViewTagName [
	^'input'
]

{ #category : 'callbacks' }
LuiFormInputComponent >> handleCallbackValue: value [
	self removeCssClass: 'inputFieldError'.
	[ 
		self valueAccessor candidateValue: value.
		self valueAccessor write: (self codec decode: value).
		self valueAccessor candidateValue: '' ]
			on: LcsSlotDefinitionError 
			do: [ :s |
				self addCssClass: 'inputFieldError'.
				s return: self ]
]

{ #category : 'initialize' }
LuiFormInputComponent >> initialize [
	super initialize.
	self codec: LuiNullCodec new;
	beRerendered
]

{ #category : 'initialize' }
LuiFormInputComponent >> initializeNamed: aName [
	super initializeNamed: aName.
	self callback: [ :value | self handleCallbackValue: value ]
]

{ #category : 'initialize' }
LuiFormInputComponent >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	"self callback: [ :value | self handleCallbackValue: value ]"
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
LuiFormInputComponent >> placeholderAttribute [
	^ self attributes placeholderAttribute
]
