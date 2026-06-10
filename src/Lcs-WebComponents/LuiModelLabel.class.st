Class {
	#name : 'LuiModelLabel',
	#superclass : 'LuiModelWidget',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'initialize' }
LuiModelLabel >> componentNameBaseOn: aSlotDefinition [
	^ aSlotDefinition slotName , 'Label'
]

{ #category : 'initialize' }
LuiModelLabel >> forName [
	^ self attributes forName
]

{ #category : 'initialize' }
LuiModelLabel >> forName: aString [
	self attributes forName: aString
]

{ #category : 'initialize' }
LuiModelLabel >> initializeOnSlot: aSlotDefinition model: aModel [
	super initializeOnSlot: aSlotDefinition model: aModel.
	self forName: aSlotDefinition slotName
]

{ #category : 'label' }
LuiModelLabel >> labelString [
	^ self valueAccessor label
]

{ #category : 'rendering' }
LuiModelLabel >> renderComponentOn: html [
	html label
		addCommonAttributes: self;
		with: self labelString
]
