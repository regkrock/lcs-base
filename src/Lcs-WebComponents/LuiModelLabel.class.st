Class {
	#name : 'LuiModelLabel',
	#superclass : 'LuiBaseLabel',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'initialize' }
LuiModelLabel >> forName [
	^ self properties forName
]

{ #category : 'initialize' }
LuiModelLabel >> forName: aString [
	self properties forName: aString
]

{ #category : 'initialize' }
LuiModelLabel >> initializeOnSlot: aSlotDefinition on: aComponent [
	super initializeOnSlot: aSlotDefinition on: aComponent.
	self forName: aSlotDefinition slotName
]

{ #category : 'label' }
LuiModelLabel >> labelString [
	^ self valueAccessor label
]
