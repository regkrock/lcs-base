Class {
	#name : #LuiButton,
	#superclass : #LuiComponent,
	#category : #'Lcs-WebComponents-Buttons'
}

{ #category : #'as yet unclassified' }
LuiButton >> addIcon: anIcon [
]

{ #category : #'as yet unclassified' }
LuiButton >> addLabel: aString [
	self components add: ((LuiLabel on: self) label: aString)
]

{ #category : #'as yet unclassified' }
LuiButton >> renderComponentOn: aRenderer [
	aRenderer button
		addCommonProperties: self;
		with: [ self displayValue ]
]
