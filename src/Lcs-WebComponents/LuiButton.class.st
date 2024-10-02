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
		id: self componentId;
		class: self cssClassesString;
		dataName: self componentName;
		dataStClass: self;
		with: [ self displayValue ]
]
