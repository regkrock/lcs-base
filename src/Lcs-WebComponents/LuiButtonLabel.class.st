Class {
	#name : 'LuiButtonLabel',
	#superclass : 'LuiBaseLabel',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'label' }
LuiButtonLabel >> labelString [
	^ self properties labelPropertyValue
]

{ #category : 'configuration' }
LuiButtonLabel >> labelString: aString [
	self properties labelProperty value: aString
]
