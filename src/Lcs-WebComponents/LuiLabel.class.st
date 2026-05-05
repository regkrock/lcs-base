Class {
	#name : 'LuiLabel',
	#superclass : 'LuiBaseLabel',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'label' }
LuiLabel >> labelString [
	^ self properties labelPropertyValue
]

{ #category : 'configuration' }
LuiLabel >> labelString: aString [
	self properties labelProperty value: aString
]
