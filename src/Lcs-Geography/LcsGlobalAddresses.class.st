Class {
	#name : 'LcsGlobalAddresses',
	#superclass : 'LcsAddresses',
	#instVars : [
		'unknownInstance'
	],
	#category : 'Lcs-Geography-Core',
	#package : 'Lcs-Geography',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsGlobalAddresses class >> unknownInstanceSlotDefinition [
	<accessorSlotDefinition>
	^ LcsUnknownInstanceSlot new
			addSlotType: LcsUnknownAddress;
			yourself
]

{ #category : 'accessing' }
LcsGlobalAddresses >> unknownInstance [
	^ self slotVarNamed: 'unknownInstance'
]

{ #category : 'accessing' }
LcsGlobalAddresses >> unknownInstance: anObject [
	self slotVarNamed: 'unknownInstance' put: anObject
]
