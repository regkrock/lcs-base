Class {
	#name : #LuiButtonLabel,
	#superclass : #LuiLabel,
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #label }
LuiButtonLabel >> labelString [
	^ self properties labelPropertyValue
]

{ #category : #configuration }
LuiButtonLabel >> labelString: aString [
	self properties labelProperty value: aString
]
