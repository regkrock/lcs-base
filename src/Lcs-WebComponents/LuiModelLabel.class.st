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
LuiModelLabel >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	self forName: aSlotDefinition slotName
]

{ #category : 'label' }
LuiModelLabel >> labelString [
	^ self valueAccessor label
]

{ #category : 'attributes' }
LuiModelLabel >> removeForNameAttribute [
	self attributes removeAttributeKey: LuiForNameAttribute attributeName 
]

{ #category : 'rendering' }
LuiModelLabel >> renderComponentOn: html [
	html label
		addCommonAttributes: self;
		with: self labelString
]
