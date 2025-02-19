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

{ #category : #'system model' }
LcsDomainObject class >> allSubmodules [
	^ LcsAllSubmodulesVisitor allSubmodulesFor: self
]

{ #category : #'slot definitions' }
LcsDomainObject class >> historySlotDefinition [
	<slotDefinition>
	^ LcsCompositeSlot new
		slotName: 'history';
		addSlotType: LcsDomainObjectHistory;
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

{ #category : #'unit of work' }
LcsDomainObject >> delete [

	self currentUnitOfWork deleteObject: self
]

{ #category : #accessing }
LcsDomainObject >> history [
	^ self slotVarNamed: 'history'
]

{ #category : #accessing }
LcsDomainObject >> history: anObject [
	self slotVarNamed: 'history' put: anObject
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
