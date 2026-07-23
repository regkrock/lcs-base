Class {
	#name : 'LuiDateTimeLocalInput',
	#superclass : 'LuiClosedRangeInputComponent',
	#instVars : [
		'date'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'converting' }
LuiDateTimeLocalInput >> contentsAsString [
	^ self codec encode: self valueAccessor contents
]

{ #category : 'rendering' }
LuiDateTimeLocalInput >> displayValue [
	^ self valueAccessor contents yyyymmdd
]

{ #category : 'gt views' }
LuiDateTimeLocalInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''datetime-local'''
]

{ #category : 'callbacks' }
LuiDateTimeLocalInput >> handleCallbackValue: value [ 
	self valueAccessor write: (self codec decode: value)
]

{ #category : 'initialize' }
LuiDateTimeLocalInput >> initialize [
	super initialize.
	self codec: LuiDateAndTimeCodec new.
]

{ #category : 'initialize' }
LuiDateTimeLocalInput >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super
		initializeOnSlot: aSlotDefinition
		model: aModel
		componentName: aString.
	aSlotDefinition isVirtualSlot ifTrue: [ ^ self ].
	self
		step: aSlotDefinition stepValue;
		min: (aSlotDefinition minimum ifNotNil: [ :minDateAndTime | minDateAndTime asString ]);
		max: (aSlotDefinition maximum ifNotNil: [ :maxDateAmdTime | maxDateAmdTime asString ])
]

{ #category : 'rendering' }
LuiDateTimeLocalInput >> renderComponentOn: html [
	html dateTimeLocalInput
		addCommonAttributes: self;
		onBlur: (self handleCallbackAndRenderDependents: html);
		value: self contentsAsString
]
