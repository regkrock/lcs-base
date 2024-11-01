Class {
	#name : #LuiLabel,
	#superclass : #LuiInputComponent,
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #label }
LuiLabel >> labelString [
	self subclassResponsibility

]

{ #category : #'as yet unclassified' }
LuiLabel >> renderComponentOn: html [
	html label
		addCommonProperties: self;
		"callback: [ self parentComponent showLabelOnTranscript ];"
		text: self labelString
]
