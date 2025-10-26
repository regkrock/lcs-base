Class {
	#name : #LcsPhoneNumbers,
	#superclass : #LcsDomainCollection,
	#instVars : [
		'unknown'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definitions' }
LcsPhoneNumbers class >> unknownSlotDefinition [
	<slotDefinition>
	^ LcsAccessorSlot new
		slotTypes: (OrderedCollection with: LcsUnknownPhoneNumber);
		slotName: 'unknown';
		yourself
]

{ #category : #accessing }
LcsPhoneNumbers >> unknown [
	^ self slotVarNamed: 'unknown'
]

{ #category : #accessing }
LcsPhoneNumbers >> unknown: anObject [
	self slotVarNamed: 'unknown' put: anObject
]
