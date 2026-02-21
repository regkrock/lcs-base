Class {
	#name : 'LcsSlotModel',
	#superclass : 'LcsObject',
	#instVars : [
		'domainClass',
		'virtualSlotDefinitions',
		'facadeSlotDefinitions',
		'collectionItemSlotDefinitions',
		'accessorSlotDefinitions'
	],
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'instance creation' }
LcsSlotModel class >> newOn: aDomainClass [

	^ self new 
		initializeOn: aDomainClass;
		yourself
]

{ #category : 'private' }
LcsSlotModel >> _addSlotDefinitionsIn: aSelector to: aCollection [
	(self perform: aSelector)
		keysAndValuesDo: [ :eachSlotName :eachSlotDefinition | 
			aCollection
				detect: [ :each | each slotName = eachSlotName ]
				ifNone: [ aCollection add: eachSlotDefinition ] ].
	self domainClass isNil ifTrue: [ ^ self ].
	self domainClass isRootDomainClass
		ifFalse: [ self superClassSlotModel _addSlotDefinitionsIn: aSelector to: aCollection ]
]

{ #category : 'private' }
LcsSlotModel >> _slotDefinitionNamed: aSlotName inSlotDefinitionsSelector: aSelector [
	^ (self perform: aSelector)
		at: aSlotName
		ifAbsent: [ 
			self domainClass notNil
				ifTrue: [ self domainSuperClass isDomainClass
						ifTrue: [ self domainSuperClassSlotModel
								_slotDefinitionNamed: aSlotName
								inSlotDefinitionsSelector: aSelector ]
						ifFalse: [ nil ] ]
				ifFalse: [ nil ] ]
]

{ #category : 'querying - model' }
LcsSlotModel >> accessorSlotDefinitionNamed: aSlotName [
	^ self
		_slotDefinitionNamed: aSlotName
		inSlotDefinitionsSelector: #accessorSlotDefinitions
]

{ #category : 'accessing' }
LcsSlotModel >> accessorSlotDefinitions [
	^ accessorSlotDefinitions
]

{ #category : 'accessing' }
LcsSlotModel >> accessorSlotDefinitions: aCollection [
	accessorSlotDefinitions := aCollection 
]

{ #category : 'querying - model' }
LcsSlotModel >> addAllLocalSlotDefinitionsTo: aCollection [
	self slotDefinitionsCollections
		do: [ :eachGroup | self addSlotDefinitionsInGroup: eachGroup to: aCollection ]
]

{ #category : 'querying - model' }
LcsSlotModel >> addAllSlotDefinitionsTo: aCollection [
	self addAllLocalSlotDefinitionsTo: aCollection.
	self domainClass isNil ifTrue: [ ^ aCollection ].
	self domainClass isRootDomainClass
		ifFalse: [ self superClassSlotModel addAllSlotDefinitionsTo: aCollection ]
]

{ #category : 'model - view' }
LcsSlotModel >> addCollectionViewSlotDefinitionsTo: aCollection [
	self addLocalCollectionViewSlotDefinitionsTo: aCollection.
	self domainClass isRootDomainClass
		ifFalse: [ self superClassSlotModel addCollectionViewSlotDefinitionsTo: aCollection ]
]

{ #category : 'model - view' }
LcsSlotModel >> addLocalCollectionViewSlotDefinitionsTo: aCollection [
	self accessorSlotDefinitions
		keysAndValuesDo: [ :eachSlotName :eachSlotDefinition | 
			aCollection
				detect: [ :each | each slotName = eachSlotName ]
				ifNone: [ (self isNotExlcudedFromCollectionView: eachSlotName)
								ifTrue: [ aCollection add: eachSlotDefinition ] ] ]
]

{ #category : 'model - view' }
LcsSlotModel >> addSlotDefinitionsInGroup: aSlotDefinitons to: aCollection [
	aSlotDefinitons
		keysAndValuesDo: [ :eachSlotName :eachSlotDefinition | 
			aCollection
				detect: [ :each | each slotName = eachSlotName ]
				ifNone: [ aCollection add: eachSlotDefinition ] ]
]

{ #category : 'validation' }
LcsSlotModel >> addValidateConfigurationResultTo: aValidator [
	self accessorSlotDefinitions do: [ :eachSlotDefinition | aValidator validate: eachSlotDefinition ]
]

{ #category : 'model' }
LcsSlotModel >> allAccessorSlotDefinitions [
	^ self allSlotDefinitionsIn: LcsBaseSlot accessorSlotDefinitionsSelector
]

{ #category : 'model' }
LcsSlotModel >> allCollectionItemSlotDefinitions [
	^ self allSlotDefinitionsIn: LcsBaseSlot collectionItemSlotDefinitionsSelector
]

{ #category : 'model' }
LcsSlotModel >> allFacadeSlotDefinitions [
	^ self allSlotDefinitionsIn: LcsBaseSlot facadeSlotDefinitionsSelector
]

{ #category : 'model' }
LcsSlotModel >> allLocalSlotDefinitions [
	| allSlotDefinitions |
	allSlotDefinitions := OrderedCollection new.
	self addAllSlotDefinitionsTo:allSlotDefinitions.
	^ (allSlotDefinitions asSortedCollection: [ :a :b | a priority <= b priority ]) asOrderedCollection
]

{ #category : 'model' }
LcsSlotModel >> allSlotDefinitions [
	| allSlotDefinitions |
	allSlotDefinitions := OrderedCollection new.
	self addAllSlotDefinitionsTo:allSlotDefinitions.
	^ (allSlotDefinitions asSortedCollection: [ :a :b | a priority <= b priority ]) asOrderedCollection
]

{ #category : 'model' }
LcsSlotModel >> allSlotDefinitionsIn: aSelector [
	| allSlotDefinitions |
	allSlotDefinitions := OrderedCollection new.
	self _addSlotDefinitionsIn: aSelector to: allSlotDefinitions.
	^ (allSlotDefinitions asSortedCollection: [ :a :b | a priority <= b priority ]) asOrderedCollection
]

{ #category : 'model' }
LcsSlotModel >> allVirtualSlotDefinitions [
	^ self allSlotDefinitionsIn: LcsBaseSlot virtualSlotDefinitionsSelector
]

{ #category : 'model' }
LcsSlotModel >> allVirutalSlotDefinitions [
	^ self allSlotDefinitionsIn: LcsBaseSlot virtualSlotDefinitionsSelector
]

{ #category : 'validation' }
LcsSlotModel >> audit: anObject withAuditor: anAuditor [
	self accessorSlotDefinitions do: [ :each |  each audit: anObject withAuditor: anAuditor ]
]

{ #category : 'querying - model' }
LcsSlotModel >> collectionItemSlotDefinitionNamed: aSlotName [
	^ self
		_slotDefinitionNamed: aSlotName
		inSlotDefinitionsSelector: LcsBaseSlot collectionItemSlotDefinitionsSelector
]

{ #category : 'accessing' }
LcsSlotModel >> collectionItemSlotDefinitions [
	^ collectionItemSlotDefinitions
]

{ #category : 'accessing' }
LcsSlotModel >> collectionItemSlotDefinitions: anObject [
	collectionItemSlotDefinitions := anObject
]

{ #category : 'model' }
LcsSlotModel >> collectionViewSlotDefinitions [
	| slotDefs |
	slotDefs := OrderedCollection new.
	self addCollectionViewSlotDefinitionsTo:slotDefs.
	^ (slotDefs asSortedCollection: [ :a :b | a priority <= b priority ]) asOrderedCollection
]

{ #category : 'accessing' }
LcsSlotModel >> domainClass [
	^ domainClass
]

{ #category : 'accessing' }
LcsSlotModel >> domainClass: anObject [
	domainClass := anObject
]

{ #category : 'model' }
LcsSlotModel >> domainSuperClass [
	^ self domainClass superclass
]

{ #category : 'model' }
LcsSlotModel >> domainSuperClassSlotModel [
	self domainSuperClass hasSlotModel ifTrue: [ ^ self domainSuperClass slotModel ].
	LcsUndefinedSlotModelError signalSuperclassWithoutSlotModel: self domainSuperClass
]

{ #category : 'querying - model' }
LcsSlotModel >> facadeSlotDefinitionNamed: aSlotName [
	^ self
		_slotDefinitionNamed: aSlotName
		inSlotDefinitionsSelector: LcsBaseSlot facadeSlotDefinitionsSelector
]

{ #category : 'accessing' }
LcsSlotModel >> facadeSlotDefinitions [
	^ facadeSlotDefinitions
]

{ #category : 'accessing' }
LcsSlotModel >> facadeSlotDefinitions: anObject [
	facadeSlotDefinitions := anObject
]

{ #category : 'slot access' }
LcsSlotModel >> getPersistedValueOf: aString in: anObject [
	^ (self slotDefinitionNamed: aString) persistedSlotVarIn: anObject
]

{ #category : 'querying - model' }
LcsSlotModel >> globalCollectionSlots [
	^ self accessorSlotDefinitions values select: [ :each | each isGlobalCollectionSlot ]
]

{ #category : 'gt views' }
LcsSlotModel >> gtViewSlotModelChildren [
	| children |
	children := OrderedCollection new.
	self accessorSlotDefinitions keysAndValuesDo: [ :key :value |
		children add: (LcsSlotModelViewItem newLabel: key item: value)].
	^ children
]

{ #category : 'gt views' }
LcsSlotModel >> gtViewSlotModelFor: aView [
	<gtView>
	<gtClassView>
	^ aView lcsFilteredColumnedList
		title: 'Slot Model';
		priority: 10;
		items: [ self allSlotDefinitions ];
		column: 'Name' text: [ :each | each slotName ] width: 150;
		column: 'Slot Class' text: [ :each | each class name ] width: 140;
		column: 'Defined In' text: [ :each | each domainClass name ] width: 140;
		column: 'Priority' text: [ :each | each priority ] width: 30;
		column: 'Type(s)' text: [ :each | each slotTypesList];
		column: '' stencil: [ :each | 
			BrButton new
				icon: BrGlamorousVectorIcons refresh;
				aptitude: BrGlamorousButtonWithIconAptitude new;
				fitContent;
				beTinySize;
				label: 'Reinstall Slot';
				action: [ :aButton | 
					each domainClass installAccessorSlotDefinition: each slotDefinitionSelector.
					aButton phlow fireViewUpdateWish ]] width: 40; 
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect Slot Model'
			action: [ :aButton :aTab | 
				aButton phlow spawnObject: self ];
		actionButtonIcon: BrGlamorousVectorIcons browse 
			tooltip: 'Browse ' , self class name
			action: [ :aButton :aTab | 
				aButton phlow spawnObject: self class ];
		actionUpdateButton;
		yourself

]

{ #category : 'testing' }
LcsSlotModel >> hasAccessorSlotDefinitionNamed: aSlotName [
	^ (self accessorSlotDefinitionNamed: aSlotName) notNil
]

{ #category : 'testing' }
LcsSlotModel >> hasCollectionItemSlotDefinitionNamed: aSlotName [
	^ (self collectionItemSlotDefinitionNamed: aSlotName) notNil
]

{ #category : 'testing' }
LcsSlotModel >> hasFacadeSlotDefinitionNamed: aSlotName [
	^ (self facadeSlotDefinitionNamed: aSlotName) notNil
]

{ #category : 'testing' }
LcsSlotModel >> hasSlotDefinitionNamed: aSlotName [
	^ (self hasAccessorSlotDefinitionNamed: aSlotName) or: [
		(self hasCollectionItemSlotDefinitionNamed: aSlotName) or: [
		(self hasFacadeSlotDefinitionNamed: aSlotName) or: [
		(self hasVirtualSlotDefinitionNamed: aSlotName) ] ] ]
]

{ #category : 'testing' }
LcsSlotModel >> hasSlotDefinitions [
	^ self allSlotDefinitions notEmpty
]

{ #category : 'testing' }
LcsSlotModel >> hasVirtualSlotDefinitionNamed: aSlotName [
	^ (self virtualSlotDefinitionNamed: aSlotName) notNil
]

{ #category : 'initialize' }
LcsSlotModel >> initialize [
	super initialize.
	self accessorSlotDefinitions: LcsSmalltalkConfiguration identityDictionaryClass new.
	self virtualSlotDefinitions: LcsSmalltalkConfiguration identityDictionaryClass new.
	self facadeSlotDefinitions: LcsSmalltalkConfiguration identityDictionaryClass new.
	self collectionItemSlotDefinitions: LcsSmalltalkConfiguration identityDictionaryClass new.
]

{ #category : 'initialize' }
LcsSlotModel >> initializeOn: aDomainClass [ 
	self domainClass: aDomainClass
]

{ #category : 'model' }
LcsSlotModel >> initializeSlotNamed: aSlotName in: aDomainObject [
	(self slotDefinitionNamed: aSlotName) initializeSlotValueIn: aDomainObject
]

{ #category : 'model' }
LcsSlotModel >> initializeSlotValuesIn: aDomainObject [
	LcsLogger logReceiver: thisContext receiver message: thisContext message; indent.
	self allAccessorSlotDefinitions
		do: [ :eachDefintion | eachDefintion initializeSlotValueIn: aDomainObject ].
	self allCollectionItemSlotDefinitions 
		do: [ :eachDefintion | eachDefintion initializeSlotValueIn: aDomainObject ].
	LcsLogger outdent
]

{ #category : 'model' }
LcsSlotModel >> initializeUnintializedSlotValuesIn: aDomainObject [
	self allAccessorSlotDefinitions do: [ :eachDefinition | eachDefinition initializeUnintializedSlotValueIn: aDomainObject ].
	self allCollectionItemSlotDefinitions do: [ :eachDefinition | eachDefinition initializeUnintializedSlotValueIn: aDomainObject ]
]

{ #category : 'model' }
LcsSlotModel >> installSlotDefinition: aSlotDefinition [
	aSlotDefinition parent: self.
	(self perform: (aSlotDefinition pragmaSelector , 's') asSymbol)
		at: aSlotDefinition slotName put: aSlotDefinition
]

{ #category : 'testing' }
LcsSlotModel >> isNotExlcudedFromCollectionView: eachSlotName [
	^ (self domainClass slotNamesExcludedFromCollectionViewSlotDefinitions
		includes: eachSlotName) not
]

{ #category : 'loading' }
LcsSlotModel >> loadSingletonCodeCollections [
	self accessorSlotDefinitions do: [ :eachSlotDefinition |
		eachSlotDefinition class = LcsSingletonValueObjectsGlobalCollectionSlot ifTrue: [ eachSlotDefinition populateCollection  ] ]
]

{ #category : 'querying - model' }
LcsSlotModel >> localCollectionSlots [
	^ self allAccessorSlotDefinitions select: [ :each | each isLocalCollectionSlot ]
]

{ #category : 'accessing' }
LcsSlotModel >> parent [
	^ self domainClass
]

{ #category : 'accessing' }
LcsSlotModel >> parent: aDomainClass [ 
	self domainClass: aDomainClass
]

{ #category : 'model' }
LcsSlotModel >> parentSlotDefinition [
	^ self slotDefinitionNamed: 'parent'
]

{ #category : 'model' }
LcsSlotModel >> parentSuperclass [
	^ self parent superclass
]

{ #category : 'printing' }
LcsSlotModel >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: '(';
		nextPutAll: (self domainClass ifNotNil: [ self domainClass name ]) asString ;
		nextPutAll: ')'
]

{ #category : 'model' }
LcsSlotModel >> removeSlotDefinitionNamed: aSlotName [
	self slotDefinitionsCollections
		do: [ :eachSlotDefinitionsCollection | eachSlotDefinitionsCollection removeKey: aSlotName ifAbsent: [ ] ]
]

{ #category : 'model' }
LcsSlotModel >> slotDefinitionNamed: aSlotName [
	self slotDefinitionsSelectors do: [ :eachSelector |
		(self _slotDefinitionNamed: aSlotName inSlotDefinitionsSelector: eachSelector) ifNotNil: [ :definition | ^ definition ] ].
	LcsSlotDoesNotExistInSlotModelError
		signalWithContext: self
		slotName: aSlotName
]

{ #category : 'model' }
LcsSlotModel >> slotDefinitionsCollections [
	^ {self accessorSlotDefinitions.
		self collectionItemSlotDefinitions.
		self facadeSlotDefinitions.
		self virtualSlotDefinitions}
]

{ #category : 'model' }
LcsSlotModel >> slotDefinitionsSelectors [
	^ LcsBaseSlot slotDefinitionsSelectors
]

{ #category : 'model' }
LcsSlotModel >> superClassSlotModel [
	^ self domainClass superclass slotModel ifNil: [
		LcsSlotModelNotInitializedError signalWithContext: self domainClass superclass ]
]

{ #category : 'validation' }
LcsSlotModel >> validate: anObject visitor: aValidationVisitor [
	self accessorSlotDefinitions do: [ :each |  each validate: anObject visitor: aValidationVisitor ]
]

{ #category : 'querying - model' }
LcsSlotModel >> virtualSlotDefinitionNamed: aSlotName [
	^ self
		_slotDefinitionNamed: aSlotName
		inSlotDefinitionsSelector: LcsBaseSlot virtualSlotDefinitionsSelector
]

{ #category : 'accessing' }
LcsSlotModel >> virtualSlotDefinitions [
	^ virtualSlotDefinitions
]

{ #category : 'accessing' }
LcsSlotModel >> virtualSlotDefinitions: anObject [
	virtualSlotDefinitions := anObject
]
