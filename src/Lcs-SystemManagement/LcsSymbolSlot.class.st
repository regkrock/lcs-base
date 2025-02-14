Class {
	#name : #LcsSymbolSlot,
	#superclass : #LcsStringSlot,
	#instVars : [
		'inputConversionBlock'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'as yet unclassified' }
LcsSymbolSlot >> defaultInitialValueBlock [
	^ [ #'' ]
]

{ #category : #'slot definition' }
LcsSymbolSlot >> inputConversionBlock: aBlock [ 
	inputConversionBlock := aBlock
]

{ #category : #configuration }
LcsSymbolSlot >> typeClass [
	<todo: 'This needs to use UTF-8 string calss'> 
	^ Symbol
]
