Class {
	#name : #LcsDomainObjectChangeRecord,
	#superclass : #LcsDomainObject,
	#instVars : [
		'userId',
		'created',
		'changes'
	],
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'slot definition' }
LcsDomainObjectChangeRecord class >> changesSlotDefinition [
	<slotDefinition>
	^ LcsOrderedCollectionSlot new
		slotName: 'changes';
		yourself
]

{ #category : #'slot definition' }
LcsDomainObjectChangeRecord class >> createdSlotDefinition [
	<slotDefinition>
	^ LcsTimestampSlot new
		slotName: 'created';
		yourself
]

{ #category : #'slot definition' }
LcsDomainObjectChangeRecord class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsCollectionReferenceSlot new
		slotName: 'parent';
		addSlotType: LcsDomainObjectChangeRecords
		yourself
]

{ #category : #'slot definition' }
LcsDomainObjectChangeRecord class >> userIdSlotDefinition [
	<slotDefinition>
	^ LcsUserIdSlot new
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> changes [
	^ changes
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> changes: anObject [
	changes := anObject
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> created [
	^ created
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> created: anObject [
	created := anObject
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> userId [
	^ userId
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> userId: anObject [
	userId := anObject
]
