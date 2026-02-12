Class {
	#name : 'LcsGlobalPhoneNumbers',
	#superclass : 'LcsPhoneNumbers',
	#instVars : [
		'unknownInstance'
	],
	#category : 'Lcs-LegalEntities-Core',
	#package : 'Lcs-LegalEntities',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsGlobalPhoneNumbers class >> unknownInstanceSlotDefinition [
	<accessorSlotDefinition>
	^ LcsUnknownInstanceSlot new
			addSlotType: LcsUnknownPhoneNumber;
			yourself
]

{ #category : 'accessing' }
LcsGlobalPhoneNumbers >> unknownInstance [
	^ self slotVarNamed: 'unknownInstance'
]

{ #category : 'accessing' }
LcsGlobalPhoneNumbers >> unknownInstance: anObject [
	self slotVarNamed: 'unknownInstance' put: anObject
]
