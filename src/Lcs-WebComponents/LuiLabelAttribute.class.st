Class {
	#name : 'LuiLabelAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'constant\t' }
LuiLabelAttribute class >> attributeName [
	^ 'label'
]

{ #category : 'initialize' }
LuiLabelAttribute >> initialize [
	super initialize.
	self valueBlock: [ '<nil>' ]
]

{ #category : 'accessing' }
LuiLabelAttribute >> label: aString [
	self valueBlock: [ aString ]
]

{ #category : 'as yet unclassified' }
LuiLabelAttribute >> labelBlock: aBlock [
	self valueBlock: aBlock
]

{ #category : 'as yet unclassified' }
LuiLabelAttribute >> value: aString [
	self valueBlock: [ aString ]
]
