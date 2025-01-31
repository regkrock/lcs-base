Class {
	#name : #LcsSlotModel,
	#superclass : #LcsObject,
	#instVars : [
		'domainClass',
		'slotDefinitions'
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
LcsSlotModel >> _slotDefinitionNamed: aSlotName [
	^ self slotDefinitions
		at: aSlotName
		ifAbsent: [ nil
			"self domainSuperClass isDomainClass
				ifTrue: [
					self domainSuperClassSlotModel  _slotDefinitionNamed: aSlotName]
				ifFalse: [ nil ]" ]
]

{ #category : #slots }
LcsSlotModel >> addSlotDefinition: aSlotDefinition [

	aSlotDefinition parent: self.
	self slotDefinitions at: aSlotDefinition slotName put: aSlotDefinition
]

{ #category : #model }
LcsSlotModel >> addSlotDefinitionsTo: aCollection [
	self slotDefinitions keysAndValuesDo: [ :eachSlotName :eachSlotDefinition |
		aCollection detect: [ :each | each slotName = eachSlotName ]
			ifNone: [ aCollection add: eachSlotDefinition ] ].
	self domainClass isRootDomainClass
		ifFalse: [ self superClassSlotModel addSlotDefinitionsTo: aCollection ]
]

{ #category : #validation }
LcsSlotModel >> addValidateConfigurationResultTo: aValidator [
	self slotDefinitions do: [ :eachSlotDefintion | aValidator validate: eachSlotDefintion ]
]

{ #category : #model }
LcsSlotModel >> allSlotDefinitions [
	| allSlotDefinitions |
	allSlotDefinitions := OrderedCollection new.
	self addSlotDefinitionsTo:allSlotDefinitions.
	^ allSlotDefinitions
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

{ #category : #'as yet unclassified' }
LcsSlotModel >> getPersistedValueOf: aString in: anObject [
	^ (self slotDefinitionNamed: aString) persistedSlotVarIn: anObject
]

{ #category : #query }
LcsSlotModel >> globalCollectionSlots [
	^ self slotDefinitions values select: [ :each | each isGlobalCollectionSlot ]
]

{ #category : #'gt view' }
LcsSlotModel >> gtViewSlotModelChildren [
	| children |
	children := OrderedCollection new.
	self slotDefinitions keysAndValuesDo: [ :key :value |
		children add: (LcsSlotModelViewItem newLabel: key item: value)].
	^ children
]

{ #category : #'gt view' }
LcsSlotModel >> gtViewSlotModelFor: aView [
	<gtView>
	<gtClassView>
	^ aView empty
	"^ aView columnedList
		title: 'Domain Slot Definitions';
		priority: 10;
		items: [ self allSlotDefinitions ];
		column: 'Name' text: [ :each | each slotName ];
		column: 'Class' text: [ :each | each class name ];
		column: 'Defined In' text: [ :each | each domainClass name ];
		column: '' stencil: [ :each | BrButton new
										aptitude: BrGlamorousButtonWithLabelAptitude new;
										label: 'Remove';
										action: [ :aButton | self domainClass removeDomainSlotNamed: each slotName ]] width: 70; 
		actionUpdateButton;
		yourself"

]

{ #category : #slots }
LcsSlotModel >> hasSlotDefinitionNamed: aSlotName [
	^ (self _slotDefinitionNamed: aSlotName) notNil
]

{ #category : #testing }
LcsSlotModel >> hasSlotDefinitions [
	^ self allSlotDefinitions notEmpty
]

{ #category : #accessing }
LcsSlotModel >> initialize [
	super initialize.
	self slotDefinitions: LcsSmalltalkConfiguration identityDictionaryClass new.
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
	self allSlotDefinitions do: [ :eachDefintion | eachDefintion initializeSlotValueIn: aDomainObject ]
]

{ #category : #model }
LcsSlotModel >> initializeUnintializedSlotValuesIn: aDomainObject [
	self allSlotDefinitions do: [ :eachDefinition | eachDefinition initializeUnintializedSlotValueIn: aDomainObject ]
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
	| slotDefinition |
	slotDefinition := self _slotDefinitionNamed: aSlotName.
	slotDefinition
		ifNil: [ LcsSlotDoesNotExistInSlotModelError
				signalWithContext: self
				slotName: aSlotName ].
	^ slotDefinition
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
