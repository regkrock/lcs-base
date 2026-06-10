Class {
	#name : 'LuiLabel',
	#superclass : 'LuiModelWidget',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

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
LuiLabel >> initializeOnSlot: aSlotDefinition model: aModel [
	super initializeOnSlot: aSlotDefinition model: aModel.
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

{ #category : 'rendering' }
LuiLabel >> renderComponentOn: html [
	html label
		addCommonAttributes: self;
		with: [ html text: self text ]
]
