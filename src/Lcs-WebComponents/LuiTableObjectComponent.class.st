Class {
	#name : 'LuiTableObjectComponent',
	#superclass : 'LuiComponent',
	#instVars : [
		'valueAccessor'
	],
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LuiTableObjectComponent class >> onSlot: aSlotDefinition model: aModel [
	^ self
		onSlot: aSlotDefinition
		model: aModel
		componentName: aSlotDefinition slotName
]

{ #category : 'instance creation' }
LuiTableObjectComponent class >> onSlot: aSlotDefinition model: aModel componentName: aString [ 
	^ self new
		initializeOnSlot: aSlotDefinition model: aModel componentName: aString;
		yourself
]

{ #category : 'instance creation' }
LuiTableObjectComponent class >> onSlotNamed: aSlotName model: aModel [
	^ self onSlot: (aModel slotDefinitionNamed: aSlotName) model: aModel
]

{ #category : 'instance creation' }
LuiTableObjectComponent >> _initializeOnSlot: aSlotDefinition model: aModel componentName: aString [ 
	self
		valueAccessor: (LuiSlotAccessor
				newOn: self
				slotDefinition: aSlotDefinition
				model: aModel).
	self componentName: aString.
	aSlotDefinition isVirtualSlot ifTrue: [ self attributes beDisabled ] 
]

{ #category : 'instance creation' }
LuiTableObjectComponent >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [ 
	self
		_initializeOnSlot: aSlotDefinition
		model: aModel
		componentName: aString.
	aSlotDefinition configureWidgetComponent: self model: aModel
]

{ #category : 'components' }
LuiTableObjectComponent >> tableRoot [
	^ self parentComponent tableRoot
]

{ #category : 'accessing' }
LuiTableObjectComponent >> valueAccessor [
	^ valueAccessor
]

{ #category : 'accessing' }
LuiTableObjectComponent >> valueAccessor: anObject [
	valueAccessor := anObject
]
