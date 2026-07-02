Class {
	#name : 'LuiLabel',
	#superclass : 'LuiModelWidget',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'instance creation' }
LuiLabel class >> onSlot: aSlotDefinition model: aModel [
	^ self
		onSlot: aSlotDefinition
		model: aModel
		componentName: aSlotDefinition slotName , 'Label'
	
]

{ #category : 'attributes' }
LuiLabel >> for [
	^ self attributes for
]

{ #category : 'attributes' }
LuiLabel >> for: anInputName [
	self attributes for: anInputName
]

{ #category : 'gt views' }
LuiLabel >> gtViewTagName [
	^'label'
]

{ #category : 'iniitialize' }
LuiLabel >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	self _initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	self text: aSlotDefinition label.
	self attributes for: aSlotDefinition slotName
]

{ #category : 'attributes' }
LuiLabel >> removeForAttribute [
	self attributes removeAttributeKey: LuiForNameAttribute attributeName 
]

{ #category : 'rendering' }
LuiLabel >> renderComponentOn: html [
	html label
		addCommonAttributes: self;
		with: [ html text: self text ]
]
