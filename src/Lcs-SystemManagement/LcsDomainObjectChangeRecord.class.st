Class {
	#name : #LcsDomainObjectChangeRecord,
	#superclass : #LcsSupportDomainObject,
	#instVars : [
		'userUuid',
		'created',
		'changes'
	],
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'slot definitions' }
LcsDomainObjectChangeRecord class >> changesSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'changes';
		addSlotType: LcsDomainObjectSlotChanges;
		addCollectionMemberType: LcsDomainObjectSlotChange;
		makeDirectUpdateOfVariable;
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectChangeRecord class >> createdSlotDefinition [
	<slotDefinition>
	^ LcsChangeRecordTimestampSlot new
		slotName: 'created';
		makeDirectUpdateOfVariable;
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectChangeRecord class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsCollectionReferenceSlot new
		slotName: 'parent';
		addSlotType: LcsDomainObjectChangeRecords;
		makeDirectUpdateOfVariable;
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectChangeRecord class >> userSlotDefinition [
	<facadeSlotDefinition>
	^ LcsFacadeSlot new
		slotName: 'user';
		targetSlotName: 'userUuid';
		convertFromTarget: [ :userUuid | self currentSystem securityModule userWithUuid: userUuid ];
		convertToTarget: [ :user | user uuid ];
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectChangeRecord class >> userUuidSlotDefinition [
	<slotDefinition>
	^ LcsChangeRecordUserUuidSlot new
		makeDirectUpdateOfVariable;
		yourself
]

{ #category : #'as yet unclassified' }
LcsDomainObjectChangeRecord >> addOriginalValueFor: aSlotName [
	self createInitialSlotChangeFor: (self domainObject slotDefinitionNamed: aSlotName) 
]

{ #category : #history }
LcsDomainObjectChangeRecord >> addSlotChangesOf: aSlotName to: slotChangeHistory [
	self changes addSlotChangesOf: aSlotName to: slotChangeHistory
]

{ #category : #history }
LcsDomainObjectChangeRecord >> changeForSlot: aSlotName [
	^ self changes changeForSlot: aSlotName
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> changes [
	^ changes
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> changes: anObject [
	changes := anObject
]

{ #category : #'history saving' }
LcsDomainObjectChangeRecord >> createInitialSlotChangeFor: eachSlotDefinition [ 
	self changes createInitialSlotChangeFor: eachSlotDefinition 
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> created [
	^ created
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> created: anObject [
	created := anObject
]

{ #category : #'domain object' }
LcsDomainObjectChangeRecord >> domainObject [
	^ self parent domainObject
]

{ #category : #history }
LcsDomainObjectChangeRecord >> domainObjectHistory [
	^ self parent domainObjectHistory
]

{ #category : #testing }
LcsDomainObjectChangeRecord >> hasChangeHistoryFor: aSlotName [
	^ self changes hasChangeHistoryFor: aSlotName
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> user [
	^ self slotVarNamed: 'user'
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> user: aUser [
	self slotVarNamed: 'user' put: aUser
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> userUuid [
	^ userUuid
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> userUuid: anObject [
	userUuid := anObject
]
