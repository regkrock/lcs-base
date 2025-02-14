"
This has the following information:
1) Created timestamp.
2) User who created the instance of a domain object.
3) Change Log - this is a log of all changes. For each change a new change log is created.
"
Class {
	#name : #LcsDomainObjectHistory,
	#superclass : #LcsSupportDomainObject,
	#instVars : [
		'created',
		'userId',
		'changeRecords'
	],
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'application environment' }
LcsDomainObjectHistory class >> addToUnitOfWork: newObject [
	"this is not saved in the Unit of Work as it is part of the unit of work"
]

{ #category : #'slot definitions' }
LcsDomainObjectHistory class >> changeRecordsSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'changeRecords';
		addSlotType: LcsDomainObjectChangeRecords;
		addCollectionMemberType: LcsDomainObjectChangeRecord;
		beRequired;
		"beReadOnly;"
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectHistory class >> createdSlotDefinition [
	<slotDefinition>
	^ LcsChangeRecordTimestampSlot new
		slotName: 'created';
		beRequired;
		"beReadOnly;"
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectHistory class >> userIdSlotDefinition [
	<slotDefinition>
	^ LcsChangeRecordUserIdSlot new
]

{ #category : #'slot definitions' }
LcsDomainObjectHistory class >> userSlotDefinition [
	"<slotDefinition>"
	^ LcsFacadeSlot new
		slotName: 'user';
		targetSlotName: 'userId';
		convertFromTarget: [ :userId | self accessControlModule userWithId: userId ];
		convertToTarget: [ :user | user userId ];
		"beReadOnly;"
		yourself
]

{ #category : #accessing }
LcsDomainObjectHistory >> changeRecords [
	^ self slotVarNamed: 'changeRecords'
]

{ #category : #accessing }
LcsDomainObjectHistory >> changeRecords: anObject [
	self slotVarNamed: 'changeRecords' put: anObject
]

{ #category : #accessing }
LcsDomainObjectHistory >> created [
	^ self slotVarNamed: 'created'
]

{ #category : #accessing }
LcsDomainObjectHistory >> created: anObject [
	self slotVarNamed: 'created' put: anObject
]

{ #category : #acccessing }
LcsDomainObjectHistory >> userId [
	^ self slotVarNamed: 'userId'
]

{ #category : #accessing }
LcsDomainObjectHistory >> userId: aString [
	self slotVarNamed: 'userId' put: aString
]
