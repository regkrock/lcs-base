Class {
	#name : #LuiLabel,
	#superclass : #LuiEnterableComponent,
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #'as yet unclassified' }
LuiLabel >> renderComponentOn: html [
	html span
		"addCommonProperties: self;"
		"callback: [ self parentComponent showLabelOnTranscript ];"
		with: self displayValue
]
