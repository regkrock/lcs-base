Class {
	#name : 'LcsGlobalAddresses',
	#superclass : 'LcsAddresses',
	#instVars : [
		'unknownInstance',
		'unknownMainAddress'
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

{ #category : 'slot definitions' }
LcsGlobalAddresses class >> unknownMainAddressSlotDefinition [
	<accessorSlotDefinition>
	^ LcsUnknownInstanceSlot new
			slotName: 'unknownMainAddress';
			addSlotType: LcsUnknownAddress;
			initialValueBlock: [ :parentDomainObject :slot | 
				(slot slotTypes any new)
					parent: parentDomainObject;
					addressType: 'main';
					yourself ];
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

{ #category : 'accessing' }
LcsGlobalAddresses >> unknownMainAddress [
	^ self slotVarNamed: 'unknownMainAddress'
]

{ #category : 'accessing' }
LcsGlobalAddresses >> unknownMainAddress: anObject [
	self slotVarNamed: 'unknownMainAddress' put: anObject
]
