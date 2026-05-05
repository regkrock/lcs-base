Class {
	#name : 'LuiBaseLabel',
	#superclass : 'LuiInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'label' }
LuiBaseLabel >> labelString [
	self subclassResponsibility

]

{ #category : 'rendering' }
LuiBaseLabel >> renderComponentOn: html [
	html label
		addCommonProperties: self;
		with: self labelString
]
