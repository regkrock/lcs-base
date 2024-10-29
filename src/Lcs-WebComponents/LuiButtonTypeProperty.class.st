Class {
	#name : #LuiButtonTypeProperty,
	#superclass : #LuiComponentProperty,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #constants }
LuiButtonTypeProperty class >> propertyName [
	^ 'buttonType'
]

{ #category : #configuration }
LuiButtonTypeProperty >> beButtonType [
	self valueBlock: [ 'button' ]
]

{ #category : #configuration }
LuiButtonTypeProperty >> beSubmitType [
	self valueBlock: [ 'submit' ]
]

{ #category : #'as yet unclassified' }
LuiButtonTypeProperty >> initialize [
	super initialize.
	self beButtonType
]
