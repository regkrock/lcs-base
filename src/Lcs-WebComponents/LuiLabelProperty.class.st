Class {
	#name : 'LuiLabelProperty',
	#superclass : 'LuiComponentProperty',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constant\t' }
LuiLabelProperty class >> propertyName [
	^ 'label'
]

{ #category : 'initialize' }
LuiLabelProperty >> initialize [
	super initialize.
	self valueBlock: [ '<nil>' ]
]

{ #category : 'as yet unclassified' }
LuiLabelProperty >> label: aString [
	self valueBlock: [ aString ]
]

{ #category : 'as yet unclassified' }
LuiLabelProperty >> labelBlock: aBlock [
	self valueBlock: aBlock
]

{ #category : 'as yet unclassified' }
LuiLabelProperty >> value: aString [
	self valueBlock: [ aString ]
]
