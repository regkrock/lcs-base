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

{ #category : #querying }
LcsDomainObject class >> classNamesPrefixTree [
	^ GtPrefixTree withAll: (self allSubclasses collect: #name)
]

{ #category : #'slot definitions' }
LcsDomainObject class >> creationDateSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlot new
			slotName: 'creationDate';
			valueAccessor: #historyCreationDate;
			addSlotType: Date;
			yourself
]

{ #category : #'slot definitions' }
LcsDomainObject class >> creationTimestampSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlot new
			slotName: 'creationTimestamp';
			valueAccessor: #historyCreationTimestamp;
			addSlotType: DateAndTime;
			yourself
]

{ #category : #'slot definitions' }
LcsDomainObject class >> creatorSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlot new
			slotName: 'creator';
			valueAccessor: #historyCreator;
			addSlotType: LcsUser;
			yourself
]

{ #category : #'slot definitions' }
LcsDomainObject class >> historySlotDefinition [
	<slotDefinition>
	^ LcsDomainObjectHistorySlot new
]

{ #category : #'slot definitions' }
LcsDomainObject class >> lastUpdatedDateSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlot new
			slotName: 'lastUpdatedDate';
			valueAccessor: #historyLastUpdatedDate;
			addSlotType: Date;
			yourself
]

{ #category : #'slot definitions' }
LcsDomainObject class >> lastUpdatedTimestampSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlot new
			slotName: 'lastUpdatedTimestamp';
			valueAccessor: #historyLastUpdatedTimestamp;
			addSlotType: DateAndTime;
			yourself
]

{ #category : #'slot definitions' }
LcsDomainObject class >> lastUpdatedUserSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlot new
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
	LcsLogger 
		log: self name , ' >> basicNew - starting';
		indent.
	newObject initialize.
	LcsLogger
		log: self name , ' >> basicNew - finished';
		outdent.
	^ newObject
]

{ #category : #'instance creation' }
LcsDomainObject class >> newInContextOf: anObject [
	"THIS TEMPORARY. IT SHOULD BE AVAILABLE ONLY TO LOCAL COLLECTION ITEMS"
	| newObject parentCollectionSlot |
	newObject := self basicNew.
	self currentSystem ifNotNil: [
		"parentCollectionSlot := self collectionSlotIn: anObject."
		parentCollectionSlot :=  anObject perform: self parentSlotDefinition collectionSlotName asSymbol.
		self currentUnitOfWork addObject: newObject toCollection: parentCollectionSlot ].
	newObject initialize.
	^ newObject 
]

{ #category : #'gt views' }
LcsDomainObject class >> slotNamesExcludedFromCollectionViewSlotDefinitions [
	^#('parent' 'history' 'uuid' 'version')
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
			priority: 100;
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
LcsDomainObject >> gtLocalCollectionsFor: aView [
	<gtView>
		self slotModel ifNil: [
			^ aView text
				title: 'Local Collections';
				priority: 9;
				text: [ 'System Is Not Active' ]].

	 self localCollections isEmpty ifTrue: [ ^ aView empty]. 

	 	^ aView columnedTree
		title: 'Local Collections';
		priority: 9;
		items: [ self localCollectionItems ];
		column: 'Slot'
			text: [ :item | item  label asString ]
			width: 100;
		column: 'Size'
			text: [ :item | item item 
								ifNil: [ '' ] 
								ifNotNil: [ item collectionSize printString ] ]
			width: 50;
		column: 'Class'
			text: [ :item | item item class asString ]
			width: 200;
		column: 'Pending Adds'
			text: [ :item | item numberOfPendingAdds asString ]
			width: 100;
		column: 'Pending Removals'
			text: [ :item | item numberOfPendingRemovals asString ]
			width: 125;
		send: #item;
		actionUpdateButton;
		yourself
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
	self version: (self version ifNil: [ 0 ]) + 1
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

{ #category : #'gt views' }
LcsDomainObject >> localCollectionItems [
	^ self slotModel localCollectionSlots
		collect: [ :eachSlotDefinition | 
			LcsLocalCollectionItem
				newLabel: eachSlotDefinition slotName
				item: (self perform: eachSlotDefinition slotName asSymbol) ]
]

{ #category : #'gt views' }
LcsDomainObject >> localCollections [
	^ self slotModel localCollectionSlots collect: [ :each | self perform: each slotName asSymbol ]
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
