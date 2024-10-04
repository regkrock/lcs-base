Class {
	#name : #LuiLabel,
	#superclass : #LuiEnterableComponent,
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #'as yet unclassified' }
LuiLabel >> renderComponentOn: aRenderer [

	aRenderer textInput
		id: self componentId;
		class: self cssClassesString;
		dataName: self componentName;
		dataStClass: self;
		with: [self displayValue]
]
