Class {
	#name : 'LuiNumberInput',
	#superclass : 'LuiClosedRangeInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'rendering' }
LuiNumberInput >> displayValue [
	self valueAccessor ifNil: [ ^ '' ].
	^ (self cssClasses includes: 'inputFieldError')
		ifTrue: [ self valueAccessor candidateValue ]
		ifFalse: [ self codec encode: valueAccessor read ]
]

{ #category : 'gt views' }
LuiNumberInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''number'''
]

{ #category : 'initialize' }
LuiNumberInput >> initialize [
	super initialize.
	self codec: LuiNumberCodec new.
	"self beNotRerendered"
]

{ #category : 'initialize' }
LuiNumberInput >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	self 
		step: aSlotDefinition stepValue;
		min: aSlotDefinition minimum;
		max: aSlotDefinition maximum
]

{ #category : 'rendering' }
LuiNumberInput >> renderComponentOn: html [
	html numberInput
		addCommonAttributes: self;
		onChange: (self handleCallbackAndRenderDependents: html);
		value: self displayValue
]
