Class {
	#name : #LcsEmailAddresses,
	#superclass : #LcsDomainCollection,
	#instVars : [
		'unknown'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definitions' }
LcsEmailAddresses class >> unknownSlotDefinition [
	<slotDefinition>
	^ LcsAccessorSlot new
		slotTypes: (OrderedCollection with: LcsUnknownEmailAddress);
		slotName: 'unknown';
		yourself
]

{ #category : #'default instance' }
LcsEmailAddresses >> defaultInstance [
	^ LcsEmailAddress new
]

{ #category : #accessing }
LcsEmailAddresses >> unknown [
	^ self slotVarNamed: 'unknown'
]

{ #category : #accessing }
LcsEmailAddresses >> unknown: anObject [
	self slotVarNamed: 'unknown' put: anObject
]
