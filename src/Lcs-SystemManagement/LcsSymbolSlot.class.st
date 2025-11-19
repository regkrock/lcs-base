Class {
	#name : 'LcsSymbolSlot',
	#superclass : 'LcsStringSlot',
	#instVars : [
		'inputConversionBlock'
	],
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsSymbolSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | #'' ]
]

{ #category : 'slot definitions' }
LcsSymbolSlot >> inputConversionBlock: aBlock [ 
	inputConversionBlock := aBlock
]

{ #category : 'configuration' }
LcsSymbolSlot >> typeClass [
	<todo: 'This needs to use UTF-8 string calss'> 
	^ Symbol
]
