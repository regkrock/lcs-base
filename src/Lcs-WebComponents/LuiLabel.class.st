Class {
	#name : #LuiLabel,
	#superclass : #LuiEnterableComponent,
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #'as yet unclassified' }
LuiLabel >> renderComponentOn: aRenderer [

	aRenderer textInput
		addCommonProperties: self;
		with: [self displayValue]
]
