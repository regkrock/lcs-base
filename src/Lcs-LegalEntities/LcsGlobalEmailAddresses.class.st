Class {
	#name : 'LcsGlobalEmailAddresses',
	#superclass : 'LcsEmailAddresses',
	#instVars : [
		'unknownInstance'
	],
	#category : 'Lcs-LegalEntities-Core',
	#package : 'Lcs-LegalEntities',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsGlobalEmailAddresses class >> unknownInstanceSlotDefinition [
	<accessorSlotDefinition>
	^ LcsUnknownInstanceSlot new
			addSlotType: LcsUnknownEmailAddress;
			yourself
]

{ #category : 'accessing' }
LcsGlobalEmailAddresses >> unknownInstance [
	^ self slotVarNamed: 'unknownInstance'
]

{ #category : 'accessing' }
LcsGlobalEmailAddresses >> unknownInstance: anObject [
	self slotVarNamed: 'unknownInstance' put: anObject
]
