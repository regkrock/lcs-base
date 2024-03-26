Class {
	#name : #LcsDomainObject,
	#superclass : #LcsObject,
	#instVars : [
		'parent'
	],
	#classInstVars : [
		'SlotDefinitions'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #'slot definitions' }
LcsDomainObject class >> addSlotDefinitions [
	self slotDefinitionMethods do: [ :eachPragma | 
			self slotDefinitions addSlotDefinition: (self perform: eachPragma methodSelector) ]
]

{ #category : #'unit of work' }
LcsDomainObject class >> addToUnitOfWork: newObject [
	self currentUnitOfWork addObject: newObject
]

{ #category : #accessing }
LcsDomainObject class >> currentSystem [

	^ LcsSystemManager currentSystem
]

{ #category : #accessing }
LcsDomainObject class >> currentSystem: aSystem [
	LcsSystemManager addNewSystem: aSystem
]

{ #category : #'unit of work' }
LcsDomainObject class >> currentUnitOfWork [
	^self currentSystem currentUnitOfWork
]

{ #category : #accessing }
LcsDomainObject class >> gtViewSlotDefinitionsFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Slot Definitions';
		priority: 99;
		"items: [ self slotDefinitions  sorted: #yourself ascending ];
		column: 'Slot Name' text: [ :id | id ];
		send: [ :id | self newForEncoding: id ];
		actionStencil: [ :aButton | 
				GtSpotterDropdownButtonStencil new
					object: self;
					tooltip: 'Search character encoders by identifier';
					id: GtPharoSearchCodeButtonId;
					objectActOn: [ :anActOnEvent :anItem :theButton | 
						
						(anItem isKindOf: ZnCharacterEncoder) ifTrue: [ 
							| columnedList |
							columnedList := theButton phlow viewContent 
								allChildrenBreadthFirstDetect: [ :child | 
									child isKindOf:  BrColumnedList ] 
								ifFound: [ :child | child ].
							columnedList scrollToItem: anItem identifier.
							columnedList selectOne: (columnedList items indexOf: anItem identifier).
							
							anActOnEvent beActed ] ];
					asElement ]"
			tooltip: 'Search character encoders by identifier'
]

{ #category : #accessing }
LcsDomainObject class >> hasNoninitializedEnvironment [
	^ self withAllSubclasses allSatisfy: [ :each | each slotDefinitions isNil ]
]

{ #category : #'slot definitions' }
LcsDomainObject class >> initializeEnvironment [
	"self slotDefinitions: (LcsSlotDefinitions newOn: self).
	self subclassesDo: [ :each | each initializeEnvironment]"
]

{ #category : #'slot definitions' }
LcsDomainObject class >> initializeSlotDefinitions [
	self slotDefinitions: (LcsSlotDefinitions newOn: self).
	self currentSystem addToSlotModel: self slotDefinitions.
	self addSlotDefinitions
]

{ #category : #'instance creation\t' }
LcsDomainObject class >> new [
	| newObject |
	newObject := self basicNew initialize.
	self currentSystem ifNotNil: [self addToUnitOfWork: newObject].
	^ newObject
]

{ #category : #'slot definitions' }
LcsDomainObject class >> releaseEnvironment [
	self slotDefinitions: nil.
	self subclassesDo: [ :each | each releaseEnvironment]
]

{ #category : #'slot definitions' }
LcsDomainObject class >> slotDefinitionMethods [
	^ Pragma allNamed: 'slotDefinition' in: self class
]

{ #category : #'slot definitions' }
LcsDomainObject class >> slotDefinitionNamed: aString [ 
	self slotDefinitions isNil ifTrue: [ ^ LcsSlotDefinitionsNotInitializedError signal: ('Slot Definitions not initialized in ' , self name) ].
	^self slotDefinitions slotDefinitionNamed: aString
]

{ #category : #accessing }
LcsDomainObject class >> slotDefinitions [
	^ SlotDefinitions
]

{ #category : #accessing }
LcsDomainObject class >> slotDefinitions: anObject [
	SlotDefinitions := anObject
]

{ #category : #accessing }
LcsDomainObject >> currentSystem [
	^ self class currentSystem
]

{ #category : #'unit of work' }
LcsDomainObject >> currentUnitOfWork [

	^ self class currentUnitOfWork
]

{ #category : #'unit of work' }
LcsDomainObject >> delete [

	self currentUnitOfWork deleteObject: self
]

{ #category : #'slot definitions' }
LcsDomainObject >> getValueOfSlotNamed: aSlotName [
	^ (self slotDefinitionNamed: aSlotName) getValueIn: self
]

{ #category : #accessing }
LcsDomainObject >> parent [
	^ parent
]

{ #category : #accessing }
LcsDomainObject >> parent: anObject [
	parent := anObject
]

{ #category : #'slot definitions' }
LcsDomainObject >> setValueOfSlotNamed: aSlotName to: onObject [
	(self slotDefinitionNamed: aSlotName) setValueTo: onObject in: self
]

{ #category : #'slot definitions' }
LcsDomainObject >> slotDefinitionNamed: aString [
	^ self class slotDefinitionNamed: aString
]

{ #category : #accessing }
LcsDomainObject >> slotDefinitions [
	^ self class slotDefinitions
]

{ #category : #accessing }
LcsDomainObject >> slotDefintions [
	^ self class slotDefinitions
]

{ #category : #validation }
LcsDomainObject >> validateConfiguration [
	self assert: self slotDefinitions class name equals: #LcsSlotDefinitions.
	self slotDefinitions validateConfiguration
]
