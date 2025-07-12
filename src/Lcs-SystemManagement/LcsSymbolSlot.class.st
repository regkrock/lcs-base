Class {
	#name : #LcsSymbolSlot,
	#superclass : #LcsStringSlot,
	#instVars : [
		'inputConversionBlock'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsSymbolSlot >> defaultInitialValueBlock [
	^ [ :domainObject :slot | #'' ]
]

{ #category : #'slot definitions' }
LcsSymbolSlot >> inputConversionBlock: aBlock [ 
	inputConversionBlock := aBlock
]

{ #category : #configuration }
LcsSymbolSlot >> typeClass [
	<todo: 'This needs to use UTF-8 string calss'> 
	^ Symbol
]
