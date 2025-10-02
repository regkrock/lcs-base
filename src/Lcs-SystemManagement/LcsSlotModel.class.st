Class {
	#name : #LcsSlotModel,
	#superclass : #LcsObject,
	#instVars : [
		'domainClass',
		'slotDefinitions',
		'virtualSlotDefinitions',
		'facadeSlotDefinitions'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #configuration }
LcsSlotModel class >> collectionClass [
	^ LcsSmalltalkConfiguration symbolDictionaryClass
]

{ #category : #'instance creation' }
LcsSlotModel class >> newOn: aDomainClass [

	^ self new 
		initializeOn: aDomainClass;
		yourself
]

{ #category : #slots }
LcsSlotModel >> _facadeSlotDefinitionNamed: aSlotName [
	^ self facadeSlotDefinitions
		at: aSlotName
		ifAbsent: [
			self domainSuperClass isDomainClass
				ifTrue: [
					self domainSuperClassSlotModel  _facadeSlotDefinitionNamed: aSlotName]
				ifFalse: [ nil ] ]
]

{ #category : #slots }
LcsSlotModel >> _slotDefinitionNamed: aSlotName [
	^ self slotDefinitions
		at: aSlotName
		ifAbsent: [
			self domainSuperClass isDomainClass
				ifTrue: [
					self domainSuperClassSlotModel  _slotDefinitionNamed: aSlotName]
				ifFalse: [ nil ] ]
]

{ #category : #slots }
LcsSlotModel >> _virtualSlotDefinitionNamed: aSlotName [
	^ self virtualSlotDefinitions
		at: aSlotName
		ifAbsent: [
			self domainSuperClass isDomainClass
				ifTrue: [
					self domainSuperClassSlotModel  _virtualSlotDefinitionNamed: aSlotName]
				ifFalse: [ nil ] ]
]

{ #category : #model }
LcsSlotModel >> addAccessorSlotDefinitionsTo: aCollection [
	self slotDefinitions keysAndValuesDo: [ :eachSlotName :eachSlotDefinition |
		aCollection detect: [ :each | each slotName = eachSlotName ]
			ifNone: [ aCollection add: eachSlotDefinition ] ].
	self domainClass isRootDomainClass
		ifFalse: [ self superClassSlotModel addAccessorSlotDefinitionsTo: aCollection ]
]

{ #category : #model }
LcsSlotModel >> addAllSlotDefinitionsTo: aCollection [
	self slotDefinitions keysAndValuesDo: [ :eachSlotName :eachSlotDefinition |
		aCollection detect: [ :each | each slotName = eachSlotName ]
			ifNone: [ aCollection add: eachSlotDefinition ] ].
	self virtualSlotDefinitions keysAndValuesDo: [ :eachSlotName :eachSlotDefinition |
		aCollection detect: [ :each | each slotName = eachSlotName ]
			ifNone: [ aCollection add: eachSlotDefinition ] ].
	self domainClass isRootDomainClass
		ifFalse: [ self superClassSlotModel addAllSlotDefinitionsTo: aCollection ]
]

{ #category : #model }
LcsSlotModel >> addCollectionViewSlotDefinitionsTo: aCollection [
	self addLocalCollectionViewSlotDefinitionsTo: aCollection.
	self domainClass isRootDomainClass
		ifFalse: [ self superClassSlotModel addCollectionViewSlotDefinitionsTo: aCollection ]
]

{ #category : #slots }
LcsSlotModel >> addFacadeSlotDefinition: aSlotDefinition [

	aSlotDefinition parent: self.
	self facadeSlotDefinitions at: aSlotDefinition slotName put: aSlotDefinition
]

{ #category : #model }
LcsSlotModel >> addLocalCollectionViewSlotDefinitionsTo: aCollection [
	self slotDefinitions
		keysAndValuesDo: [ :eachSlotName :eachSlotDefinition | 
			aCollection
				detect: [ :each | each slotName = eachSlotName ]
				ifNone: [ (self isNotExlcudedFromCollectionView: eachSlotName)
								ifTrue: [ aCollection add: eachSlotDefinition ] ] ]
]

{ #category : #slots }
LcsSlotModel >> addSlotDefinition: aSlotDefinition [

	aSlotDefinition parent: self.
	self slotDefinitions at: aSlotDefinition slotName put: aSlotDefinition
]

{ #category : #validation }
LcsSlotModel >> addValidateConfigurationResultTo: aValidator [
	self slotDefinitions do: [ :eachSlotDefintion | aValidator validate: eachSlotDefintion ]
]

{ #category : #slots }
LcsSlotModel >> addVirtualSlotDefinition: aSlotDefinition [

	aSlotDefinition parent: self.
	self virtualSlotDefinitions at: aSlotDefinition slotName put: aSlotDefinition
]

{ #category : #model }
LcsSlotModel >> allAccessorSlotDefinitions [
	| allSlotDefinitions |
	allSlotDefinitions := OrderedCollection new.
	self addAccessorSlotDefinitionsTo:allSlotDefinitions.
	^ (allSlotDefinitions asSortedCollection: [ :a :b | a priority <= b priority ]) asOrderedCollection
]

{ #category : #model }
LcsSlotModel >> allSlotDefinitions [
	| allSlotDefinitions |
	allSlotDefinitions := OrderedCollection new.
	self addAllSlotDefinitionsTo:allSlotDefinitions.
	^ (allSlotDefinitions asSortedCollection: [ :a :b | a priority <= b priority ]) asOrderedCollection
]

{ #category : #validation }
LcsSlotModel >> audit: anObject withAuditor: anAuditor [
	self slotDefinitions do: [ :each |  each audit: anObject withAuditor: anAuditor ]
]

{ #category : #model }
LcsSlotModel >> collectionViewSlotDefinitions [
	| slotDefs |
	slotDefs := OrderedCollection new.
	self addCollectionViewSlotDefinitionsTo:slotDefs.
	^ (slotDefs asSortedCollection: [ :a :b | a priority <= b priority ]) asOrderedCollection
]

{ #category : #accessing }
LcsSlotModel >> domainClass [
	^ domainClass
]

{ #category : #accessing }
LcsSlotModel >> domainClass: anObject [
	domainClass := anObject
]

{ #category : #slots }
LcsSlotModel >> domainSuperClass [
	^ self domainClass superclass
]

{ #category : #slots }
LcsSlotModel >> domainSuperClassSlotModel [
	self domainSuperClass hasSlotModel ifTrue: [ ^ self domainSuperClass slotModel ].
	LcsUndefinedSlotModelError signalSuperclassWithoutSlotModel: self domainSuperClass
]

{ #category : #accessing }
LcsSlotModel >> facadeSlotDefinitions [
	^ facadeSlotDefinitions
]

{ #category : #accessing }
LcsSlotModel >> facadeSlotDefinitions: anObject [
	facadeSlotDefinitions := anObject
]

{ #category : #'slot access' }
LcsSlotModel >> getPersistedValueOf: aString in: anObject [
	^ (self slotDefinitionNamed: aString) persistedSlotVarIn: anObject
]

{ #category : #query }
LcsSlotModel >> globalCollectionSlots [
	^ self slotDefinitions values select: [ :each | each isGlobalCollectionSlot ]
]

{ #category : #'gt views' }
LcsSlotModel >> gtViewSlotModelChildren [
	| children |
	children := OrderedCollection new.
	self slotDefinitions keysAndValuesDo: [ :key :value |
		children add: (LcsSlotModelViewItem newLabel: key item: value)].
	^ children
]

{ #category : #'gt views' }
LcsSlotModel >> gtViewSlotModelFor: aView [
	<gtView>
	<gtClassView>
	^ aView filteredColumnedList
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
					each domainClass installSlotDefinition: each slotDefinitionSelector.
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

{ #category : #slots }
LcsSlotModel >> hasSlotDefinitionNamed: aSlotName [
	^ (self _slotDefinitionNamed: aSlotName) notNil
]

{ #category : #testing }
LcsSlotModel >> hasSlotDefinitions [
	^ self allAccessorSlotDefinitions notEmpty
]

{ #category : #accessing }
LcsSlotModel >> initialize [
	super initialize.
	self slotDefinitions: LcsSmalltalkConfiguration identityDictionaryClass new.
	self virtualSlotDefinitions: LcsSmalltalkConfiguration identityDictionaryClass new.
	self facadeSlotDefinitions: LcsSmalltalkConfiguration identityDictionaryClass new.
]

{ #category : #initialize }
LcsSlotModel >> initializeOn: aDomainClass [ 
	self domainClass: aDomainClass
]

{ #category : #model }
LcsSlotModel >> initializeSlotNamed: aSlotName in: aDomainObject [
	(self slotDefinitionNamed: aSlotName) initializeSlotValueIn: aDomainObject
]

{ #category : #model }
LcsSlotModel >> initializeSlotValuesIn: aDomainObject [
	self allAccessorSlotDefinitions
		do: [ :eachDefintion | eachDefintion initializeSlotValueIn: aDomainObject ]
]

{ #category : #model }
LcsSlotModel >> initializeUnintializedSlotValuesIn: aDomainObject [
	self allAccessorSlotDefinitions do: [ :eachDefinition | eachDefinition initializeUnintializedSlotValueIn: aDomainObject ]
]

{ #category : #model }
LcsSlotModel >> isNotExlcudedFromCollectionView: eachSlotName [
	^ (self domainClass slotNamesExcludedFromCollectionViewSlotDefinitions
		includes: eachSlotName) not
]

{ #category : #'as yet unclassified' }
LcsSlotModel >> loadSingletonCodeCollections [
	self slotDefinitions do: [ :eachSlotDefinition |
		eachSlotDefinition class = LcsSingletonValueObjectsGlobalCollectionSlot ifTrue: [ eachSlotDefinition populateCollection  ] ]
]

{ #category : #query }
LcsSlotModel >> localCollectionSlots [
	^ self slotDefinitions values select: [ :each | each isLocalCollectionSlot ]
]

{ #category : #accessing }
LcsSlotModel >> parent [
	^ self domainClass
]

{ #category : #accessing }
LcsSlotModel >> parent: aDomainClass [ 
	self domainClass: aDomainClass
]

{ #category : #slots }
LcsSlotModel >> parentSlotDefinition [
	^ self slotDefinitionNamed: 'parent'
]

{ #category : #slots }
LcsSlotModel >> parentSuperclass [
	^ self parent superclass
]

{ #category : #printing }
LcsSlotModel >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: '(';
		nextPutAll: (self domainClass ifNotNil: [ self domainClass name ]) asString ;
		nextPutAll: ')'
]

{ #category : #slots }
LcsSlotModel >> removeSlotDefinitionNamed: aSlotName [
	self slotDefinitions removeKey: aSlotName ifAbsent: [ ]
]

{ #category : #slots }
LcsSlotModel >> slotDefinitionNamed: aSlotName [
	(self _slotDefinitionNamed: aSlotName) ifNotNil: [ :definition | ^ definition ].
	(self _virtualSlotDefinitionNamed: aSlotName) ifNotNil: [ :definition | ^ definition ].
	(self _facadeSlotDefinitionNamed: aSlotName) ifNotNil: [ :definition | ^ definition ].

	LcsSlotDoesNotExistInSlotModelError
		signalWithContext: self
		slotName: aSlotName
]

{ #category : #model }
LcsSlotModel >> slotDefinitions [
	^ slotDefinitions
]

{ #category : #accessing }
LcsSlotModel >> slotDefinitions: aCollection [
	slotDefinitions := aCollection 
]

{ #category : #model }
LcsSlotModel >> superClassSlotModel [
	^ self domainClass superclass slotModel
]

{ #category : #validation }
LcsSlotModel >> validate: anObject visitor: aValidationVisitor [
	self slotDefinitions do: [ :each |  each validate: anObject visitor: aValidationVisitor ]
]

{ #category : #accessing }
LcsSlotModel >> virtualSlotDefinitions [
	^ virtualSlotDefinitions
]

{ #category : #accessing }
LcsSlotModel >> virtualSlotDefinitions: anObject [
	virtualSlotDefinitions := anObject
]
