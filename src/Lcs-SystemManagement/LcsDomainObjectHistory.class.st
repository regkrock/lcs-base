"
This has the following information:
1) Created timestamp.
2) User who created the instance of a domain object.
3) Change Log - this is a log of all changes. For each change a new change log is created.
"
Class {
	#name : 'LcsDomainObjectHistory',
	#superclass : 'LcsSupportDomainObject',
	#instVars : [
		'created',
		'userUuid',
		'changeRecords'
	],
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsDomainObjectHistory class >> changeRecordsSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionSlot new
			slotName: 'changeRecords';
			addSlotType: LcsDomainObjectChangeRecords;
			addCollectionMemberType: LcsDomainObjectChangeRecord;
			beRequired;
			makeDirectUpdateOfVariable;
			"beReadOnly;"
			yourself
]

{ #category : 'slot definitions' }
LcsDomainObjectHistory class >> createdSlotDefinition [
	<slotDefinition>
	^ LcsChangeRecordTimestampSlot new
			slotName: 'created';
			beRequired;
			makeDirectUpdateOfVariable;
			"beReadOnly;"
			yourself
]

{ #category : 'slot definitions' }
LcsDomainObjectHistory class >> userSlotDefinition [
	<facadeSlotDefinition>
	^ LcsUserToUserIdConversionSlot new
]

{ #category : 'slot definitions' }
LcsDomainObjectHistory class >> userUuidSlotDefinition [
	<slotDefinition>
	^ LcsChangeRecordUserUuidSlot new
			makeDirectUpdateOfVariable;
			yourself
]

{ #category : 'as yet unclassified' }
LcsDomainObjectHistory >> addChangeRecord [
	^ self changeRecords addChangeRecord
]

{ #category : 'as yet unclassified' }
LcsDomainObjectHistory >> addChangesTo: aChangeRecord [ 
	self domainObject allAccessorSlotDefinitions
		do: [ :eachSlotDefinition | aChangeRecord createInitialSlotChangeFor: eachSlotDefinition ]
]

{ #category : 'accessing' }
LcsDomainObjectHistory >> changeRecords [
	^ self slotVarNamed: 'changeRecords'
]

{ #category : 'accessing' }
LcsDomainObjectHistory >> changeRecords: anObject [
	self slotVarNamed: 'changeRecords' put: anObject
]

{ #category : 'accessing' }
LcsDomainObjectHistory >> created [
	^ self slotVarNamed: 'created'
]

{ #category : 'accessing' }
LcsDomainObjectHistory >> created: anObject [
	self slotVarNamed: 'created' put: anObject
]

{ #category : 'history' }
LcsDomainObjectHistory >> creationDate [
	^ self created asDate
]

{ #category : 'history' }
LcsDomainObjectHistory >> creationTimestamp [
	^ self created
]

{ #category : 'domain object' }
LcsDomainObjectHistory >> domainObject [
	^ self parent
]

{ #category : 'history' }
LcsDomainObjectHistory >> domainObjectHistory [
	^ self
]

{ #category : 'testing' }
LcsDomainObjectHistory >> hasChangeHistoryFor: aSlotName [ 
	^ self addChangeRecord hasChangeHistoryFor: aSlotName
]

{ #category : 'history' }
LcsDomainObjectHistory >> historyOfAllSlotChanges [
	| allSlotChangesHistory|
	allSlotChangesHistory := OrderedCollection new.
	self domainObject allAccessorSlotDefinitions do: [ :eachSlotDefinition | 
		allSlotChangesHistory addAll: (self historyOfChangesToSlot: eachSlotDefinition slotName)].
	^ allSlotChangesHistory
]

{ #category : 'history' }
LcsDomainObjectHistory >> historyOfChangesToSlot: aSlotName [
	| slotChangeHistory |
	slotChangeHistory := OrderedCollection new.
	self changeRecords addSlotChangesOf: aSlotName to: slotChangeHistory.
	^ slotChangeHistory
]

{ #category : 'history' }
LcsDomainObjectHistory >> lastUpdatedDate [
	^ self lastUpdatedTimestamp asDate
]

{ #category : 'history' }
LcsDomainObjectHistory >> lastUpdatedTimestamp [
	self changeRecords hasNoElements ifTrue: [ ^ self created ].
	^ self changeRecords lastUpdateTimestamp
]

{ #category : 'history' }
LcsDomainObjectHistory >> lastUpdatedUser [
	self changeRecords hasNoElements ifTrue: [ ^ self user ].
	^ self changeRecords lastUpdatedUser
]

{ #category : 'history' }
LcsDomainObjectHistory >> newChangeRecord [
	^ self changeRecords newChangeRecord
]

{ #category : 'history' }
LcsDomainObjectHistory >> recordOriginalSlotValue: aSlotName [
	(self hasChangeHistoryFor: aSlotName)
		ifFalse: [ self addChangeRecord addOriginalValueFor: aSlotName ]
]

{ #category : 'history' }
LcsDomainObjectHistory >> recordSlotChanges [
	self changeRecords hasElements 
		ifTrue: [ LcsError signal: 'Attempt to record creation when it has already been recorded' ].
	self userUuid: self parent currentUser uuid.
	self user: self parent currentUser.
	self newChangeRecord 
		created: self created.
]

{ #category : 'history' }
LcsDomainObjectHistory >> recordSlotChanges: aChangesRecord [
	| changeRecord |
	changeRecord := self newChangeRecord.
	aChangesRecord changedSlots
		do: [ :each | 
			self recordOriginalSlotValue: each slotName.
			each applyChangeRecordingHistoryIn: changeRecord ]
]

{ #category : 'accessing' }
LcsDomainObjectHistory >> user [
	^ self slotVarNamed: 'user'
]

{ #category : 'accessing' }
LcsDomainObjectHistory >> user: aUser [
	self slotVarNamed: 'user' put: aUser
]

{ #category : 'accessing' }
LcsDomainObjectHistory >> userUuid [
	^ self slotVarNamed: 'userUuid'
]

{ #category : 'accessing' }
LcsDomainObjectHistory >> userUuid: aString [
	self slotVarNamed: 'userUuid' put: aString
]
