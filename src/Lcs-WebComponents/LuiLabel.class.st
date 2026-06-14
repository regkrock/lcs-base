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

{ #category : 'iniitialize' }
LuiLabel >> componentNameBaseOn: aSlotDefinition [
	^ aSlotDefinition slotName , 'Label'
]

{ #category : 'attributes' }
LuiLabel >> forName [
	^ self attributes forName
]

{ #category : 'attributes' }
LuiLabel >> forName: anInputName [
	self attributes forName: anInputName
]

{ #category : 'iniitialize' }
LuiLabel >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	self text: aSlotDefinition label.
	self attributes forName: aSlotDefinition slotName
]

{ #category : 'label' }
LuiLabel >> labelString [
	^ self text
]

{ #category : 'label' }
LuiLabel >> labelString: aString [
	self text: aString
]

{ #category : 'attributes' }
LuiLabel >> removeForNameAttribute [
	self attributes removeAttributeKey: LuiForNameAttribute attributeName 
]

{ #category : 'rendering' }
LuiLabel >> renderComponentOn: html [
	html label
		addCommonAttributes: self;
		with: [ html text: self text ]
]
