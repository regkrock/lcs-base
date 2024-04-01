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

{ #category : #'slot model' }
LcsDomainObject class >> addSlotDefinitions [
	self slotDefinitionMethods do: [ :eachPragma | 
			self slotDefinitions addSlotDefinition: (self perform: eachPragma methodSelector) ]
]

{ #category : #'unit of work' }
LcsDomainObject class >> addToUnitOfWork: newObject [
	self currentUnitOfWork addObject: newObject
]

{ #category : #environment }
LcsDomainObject class >> currentSystem [

	^ LcsApplicationEnvironment currentSystem
]

{ #category : #'application environment' }
LcsDomainObject class >> currentUnitOfWork [
	^ LcsApplicationEnvironment currentUnitOfWork
]

{ #category : #'gt view' }
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

{ #category : #testing }
LcsDomainObject class >> hasNoninitializedEnvironment [
	^ self isSlotModelReleased
]

{ #category : #environment }
LcsDomainObject class >> initializeEnvironment [
]

{ #category : #'slot model' }
LcsDomainObject class >> initializeSlotModel [
	self slotDefinitions: (LcsSlotDefinitions newOn: self).
	self currentSystem addToSlotModel: self slotDefinitions.
	self addSlotDefinitions
]

{ #category : #testing }
LcsDomainObject class >> isSlotModelReleased [
	self slotDefinitions notNil ifTrue: [ ^ false ].
	self subclasses do: [ :each | each isSlotModelReleased ].
	^ true
]

{ #category : #'instance creation\t' }
LcsDomainObject class >> new [
	| newObject |
	newObject := self basicNew initialize.
	self currentSystem ifNotNil: [ self addToUnitOfWork: newObject ].
	^ newObject
]

{ #category : #environment }
LcsDomainObject class >> releaseApplicationEnvironment [
	self releaseSlotModel
]

{ #category : #'slot model' }
LcsDomainObject class >> releaseSlotModel [
	self slotDefinitions: nil.
	self subclassesDo: [ :each | each releaseSlotModel ]
]

{ #category : #'slot model' }
LcsDomainObject class >> restorelotModel [
	self initializeSlotModel
]

{ #category : #'slot model' }
LcsDomainObject class >> slotDefinitionMethods [
	^ Pragma allNamed: 'slotDefinition' in: self class
]

{ #category : #'slot model' }
LcsDomainObject class >> slotDefinitionNamed: aString [ 
	self slotDefinitions ifNil: [ ^ LcsSlotDefinitionsNotInitializedError signal: ('Slot Definitions not initialized in ' , self name) ].
	^ self slotDefinitions slotDefinitionNamed: aString
]

{ #category : #accessing }
LcsDomainObject class >> slotDefinitions [
	^ SlotDefinitions
]

{ #category : #accessing }
LcsDomainObject class >> slotDefinitions: anObject [
	SlotDefinitions := anObject
]

{ #category : #system }
LcsDomainObject >> currentSystem [
	^ self class currentSystem
]

{ #category : #'unit of work' }
LcsDomainObject >> currentUnitOfWork [
	^ self parent currentUnitOfWork
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
