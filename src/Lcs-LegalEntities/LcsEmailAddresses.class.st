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
	^ LcsDomainObjectSlot new
			addSlotType: LcsUnknownEmailAddress;
			slotName: 'unknown';
			yourself
]

{ #category : #'default instance' }
LcsEmailAddresses >> defaultInstance [
	^ self unknown
]

{ #category : #accessing }
LcsEmailAddresses >> unknown [
	^ self slotVarNamed: 'unknown'
]

{ #category : #accessing }
LcsEmailAddresses >> unknown: anObject [
	self slotVarNamed: 'unknown' put: anObject
]
