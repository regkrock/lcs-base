Class {
	#name : #LuiLabel,
	#superclass : #LuiEnterableComponent,
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #'as yet unclassified' }
LuiLabel >> renderComponentOn: html [
	html label
		addCommonProperties: self;
		with: self displayValue
]
