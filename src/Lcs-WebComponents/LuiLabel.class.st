Class {
	#name : #LuiLabel,
	#superclass : #LuiComponent,
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #'as yet unclassified' }
LuiLabel >> renderComponentOn: aRenderer [

	aRenderer textInput
		id: self componentId;
		class: self cssClassesString;
		with: [self displayValue]
]
