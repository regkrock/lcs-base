Class {
	#name : #LcsDomainObjectChangeRecord,
	#superclass : #LcsDomainObject,
	#instVars : [
		'userId',
		'timestamp',
		'changes'
	],
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'slot definition' }
LcsDomainObjectChangeRecord class >> changesSlotDefinition [
	^ LcsOrderedCollectionSlot new
		slotName: 'changes';
		yourself
]

{ #category : #'slot definition' }
LcsDomainObjectChangeRecord class >> timestampSlotDefinition [
	<slotDefinition>
	^ LcsTimestampSlot new
]

{ #category : #'slot definition' }
LcsDomainObjectChangeRecord class >> userIdSlotDefinition [
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
LcsDomainObjectChangeRecord >> timestamp [
	^ timestamp
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> timestamp: anObject [
	timestamp := anObject
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> userId [
	^ userId
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> userId: anObject [
	userId := anObject
]
