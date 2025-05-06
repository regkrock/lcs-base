"
All instances of this class have a Domain Object History. It is created when the instance of a LcsDomainObject is created.
"
Class {
	#name : #LcsDomainObject,
	#superclass : #LcsBaseDomainObject,
	#instVars : [
		'history',
		'uuid',
		'version'
	],
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'application environment' }
LcsDomainObject class >> addToUnitOfWork: newObject [
	self currentSystem ifNil: [ ^ self ]. 
	self currentUnitOfWork addObject: newObject
]

{ #category : #'slot definitions' }
LcsDomainObject class >> creationDateSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlotDefinition new
		slotName: 'creationDate';
		valueAccessor: #historyCreationDate;
		addSlotType: Date;
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObject class >> creationTimestampSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlotDefinition new
		slotName: 'creationTimestamp';
		valueAccessor: #historyCreationTimestamp;
		addSlotType: DateAndTime;
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObject class >> creatorSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlotDefinition new
		slotName: 'creator';
		valueAccessor: #historyCreator;
		addSlotType: LcsUser;
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObject class >> historySlotDefinition [
	<slotDefinition>
	^ LcsCompositeSlot new
		slotName: 'history';
		addSlotType: LcsDomainObjectHistory;
		makeDirectVariableUpdate;
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObject class >> lastUpdatedDateSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlotDefinition new
		slotName: 'lastUpdatedDate';
		valueAccessor: #historyLastUpdatedDate;
		addSlotType: Date;
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObject class >> lastUpdatedTimestampSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlotDefinition new
		slotName: 'lastUpdatedTimestamp';
		valueAccessor: #historyLastUpdatedTimestamp;
		addSlotType: DateAndTime;
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObject class >> lastUpdatedUserSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlotDefinition new
		slotName: 'lastUpdatedUser';
		valueAccessor: #historyLastUpdatedUser;
		addSlotType: LcsUser;
		yourself
]

{ #category : #'instance creation' }
LcsDomainObject class >> new [
	| newObject |
	newObject := self basicNew.
	self addToUnitOfWork: newObject.
	newObject initialize.
	^ newObject
]

{ #category : #'slot definitions' }
LcsDomainObject class >> uuidSlotDefinition [
	<slotDefinition>
	^ LcsUuidSlot new
]

{ #category : #'slot definitions' }
LcsDomainObject class >> versionSlotDefinition [
	<slotDefinition>
	^ LcsSmallIntegerSlot new
		slotName: 'version';
		yourself
]

{ #category : #history }
LcsDomainObject >> creationDate [
	^ self slotVarNamed: 'creationDate'
]

{ #category : #'accessing - virtual slot' }
LcsDomainObject >> creationTimestamp [
	^ self slotVarNamed: 'creationTimestamp'
]

{ #category : #'accessing - virtual slot' }
LcsDomainObject >> creator [
	^ self slotVarNamed: 'creator'
]

{ #category : #'unit of work' }
LcsDomainObject >> delete [

	self currentUnitOfWork deleteObject: self
]

{ #category : #'gt views' }
LcsDomainObject >> gtUnitOfWorkFor: aView [
	<gtView>
	 self currentUnitOfWork isNil ifTrue: [ ^ aView empty]. 
	^ aView forward
		title: 'Unit Of Work (' , self currentSystem class name , ')';
		priority: 999;
		object: [ self currentUnitOfWork ];
		view: #gtUnitOfWorkFor:
]

{ #category : #accessing }
LcsDomainObject >> history [
	^ self slotVarNamed: 'history'
]

{ #category : #accessing }
LcsDomainObject >> history: anObject [
	self slotVarNamed: 'history' put: anObject
]

{ #category : #history }
LcsDomainObject >> historyCreationDate [
	^ self history creationDate
]

{ #category : #history }
LcsDomainObject >> historyCreationTimestamp [
	^ self history creationTimestamp
]

{ #category : #history }
LcsDomainObject >> historyCreator [
	^ self history user
]

{ #category : #history }
LcsDomainObject >> historyLastUpdatedDate [
	^ self history lastUpdatedDate
]

{ #category : #history }
LcsDomainObject >> historyLastUpdatedTimestamp [
	^ self history lastUpdatedTimestamp
]

{ #category : #history }
LcsDomainObject >> historyLastUpdatedUser [
	^ self history lastUpdatedUser
]

{ #category : #history }
LcsDomainObject >> historyOfAllSlotChanges [
	^ self history historyOfAllSlotChanges
]

{ #category : #history }
LcsDomainObject >> historyOfChangesToSlot: aSlotName [
	^ self history historyOfChangesToSlot: aSlotName
]

{ #category : #'unit of work' }
LcsDomainObject >> incrementVersionNumber [
	self version: self version + 1
]

{ #category : #state }
LcsDomainObject >> isInAddingState [
	"The object has been created but has not been committed. When committed the version will be incremented to 1"
	| value |
	value := self instVarNamed: 'version'.
	^ value isNil or: [ value isZero ]
]

{ #category : #state }
LcsDomainObject >> isInDeletedState [
	^ self version = SmallInteger minVal
]

{ #category : #state }
LcsDomainObject >> isInPendingDeletionState [
	"This will only be -1 from the time the object is marked as deleted until the transaction is complete.
	 When the transaction is completed, the value of version with be low values"

	^ self version = -1
]

{ #category : #'accessing - virtual slot' }
LcsDomainObject >> lastUpdatedDate [
	^ self slotVarNamed: 'lastUpdatedDate'
]

{ #category : #history }
LcsDomainObject >> lastUpdatedTimestamp [
	^ self slotVarNamed: 'lastUpdatedTimestamp'
]

{ #category : #'accessing - virtual slot' }
LcsDomainObject >> lastUpdatedUser [
	^ self slotVarNamed: 'lastUpdatedUser'
]

{ #category : #accessing }
LcsDomainObject >> uuid [
	^ self slotVarNamed: 'uuid'
]

{ #category : #accessing }
LcsDomainObject >> uuid: anObject [
	self slotVarNamed: 'uuid' put: anObject
]

{ #category : #accessing }
LcsDomainObject >> version [
	^ self slotVarNamed: 'version'
]

{ #category : #accessing }
LcsDomainObject >> version: anObject [
	self slotVarNamed: 'version' put: anObject
]
