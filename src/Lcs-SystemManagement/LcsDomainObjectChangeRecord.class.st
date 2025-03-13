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
		makeDirectVariableUpdate;
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectChangeRecord class >> createdSlotDefinition [
	<slotDefinition>
	^ LcsChangeRecordTimestampSlot new
		slotName: 'created';
		makeDirectVariableUpdate;
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectChangeRecord class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsCollectionReferenceSlot new
		slotName: 'parent';
		addSlotType: LcsDomainObjectChangeRecords;
		makeDirectVariableUpdate;
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
		makeDirectVariableUpdate;
		yourself
]

{ #category : #'history saving' }
LcsDomainObjectChangeRecord >> addChanges [
	self halt.
	"self domainObject allSlotDefinitions do: [ :eachSlotDefinition |  self createInitialSlotChangeFor:  eachSlotDefinition ]"
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
