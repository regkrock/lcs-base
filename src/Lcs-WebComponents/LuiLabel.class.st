Class {
	#name : 'LuiLabel',
	#superclass : 'LuiFormInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'iniitialize' }
LuiLabel >> initializeOnSlot: aSlotDefinition [
	super initializeOnSlot: aSlotDefinition.
	self componentName: (aSlotDefinition slotName , 'Label').
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
