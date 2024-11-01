Class {
	#name : #LuiLabel,
	#superclass : #LuiInputComponent,
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #label }
LuiLabel >> labelString [
	self subclassResponsibility

]

{ #category : #rendering }
LuiLabel >> renderComponentOn: html [
	html label
		addCommonProperties: self;
		with: self labelString
]
