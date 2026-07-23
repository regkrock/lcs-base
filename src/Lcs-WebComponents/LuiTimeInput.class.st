Class {
	#name : 'LuiTimeInput',
	#superclass : 'LuiClosedRangeInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'gt views' }
LuiTimeInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''time'''
]

{ #category : 'initialize' }
LuiTimeInput >> initialize [
	super initialize.
	self codec: LuiTimeCodec new
]

{ #category : 'initialize' }
LuiTimeInput >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	self 
		"step: aSlotDefinition stepValue;"
		min: aSlotDefinition minimum;
		max: aSlotDefinition maximum
]

{ #category : 'rendering' }
LuiTimeInput >> renderComponentOn: html [
	html timeInput5
		addCommonAttributes: self;
		onBlur: (self handleCallbackAndRenderDependents: html);
		value: self displayValue
]
