Class {
	#name : 'LuiDateTimeInput',
	#superclass : 'LuiClosedRangeInputComponent',
	#instVars : [
		'date'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'converting' }
LuiDateTimeInput >> contentsAsString [
	^ self toStringConverter convertToString:  self valueAccessor contents
]

{ #category : 'rendering' }
LuiDateTimeInput >> displayValue [
	^ self valueAccessor contents yyyymmdd
]

{ #category : 'gt views' }
LuiDateTimeInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''datetime'''
]

{ #category : 'callbacks' }
LuiDateTimeInput >> handleCallbackValue: value [ 
	self valueAccessor write: (self fromStringConverter convertFromString: value)
]

{ #category : 'initialize' }
LuiDateTimeInput >> initialize [
	super initialize.
	self toStringConverter: LuiDateAndTimeToStringConverter new.
	self fromStringConverter: LuiStringToDateAndTimeConverter new.
]

{ #category : 'initialize' }
LuiDateTimeInput >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
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
LuiDateTimeInput >> renderComponentOn: html [
	html dateTimeInput
		addCommonAttributes: self;
		onBlur: (self handleCallbackAndRenderDependents: html);
		value: self contentsAsString
]
