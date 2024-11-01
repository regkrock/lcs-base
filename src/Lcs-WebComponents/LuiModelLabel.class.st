Class {
	#name : #LuiModelLabel,
	#superclass : #LuiLabel,
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #initialize }
LuiModelLabel >> forName: aString [
	self properties forName: aString
]

{ #category : #initialize }
LuiModelLabel >> initializeOnSlot: aSlotDefinition on: aComponent [
	super initializeOnSlot: aSlotDefinition on: aComponent.
	self forName: aSlotDefinition slotName
]

{ #category : #label }
LuiModelLabel >> labelString [
	^ self valueAccessor label
]
