"
All instances of this class have a Domain Object History. It is created when the instance of a LcsDomainObject is created.
"
Class {
	#name : #LcsDomainObject,
	#superclass : #LcsObject,
	#instVars : [
		'parent',
		'history',
		'uuid',
		'version'
	],
	#classInstVars : [
		'slotModel'
	],
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'meta data' }
LcsDomainObject class >> addMyDomainClassHeirarchyTo: prebootstrapClasses [
	self allClassBetweenMyselfAndLcsDomainObject
		do: [ :each | prebootstrapClasses add: each ].
	prebootstrapClasses add: self
]

{ #category : #'application environment' }
LcsDomainObject class >> addToUnitOfWork: newObject [
	self currentUnitOfWork addObject: newObject
]

{ #category : #'meta data' }
LcsDomainObject class >> allClassBetweenMyselfAndLcsDomainObject [
	^ self allSuperclasses reverse
		reject: [ :each | (each inheritsFrom: LcsDomainObject) not ]
]

{ #category : #'slot model - verification' }
LcsDomainObject class >> assertDomainSlotRemoved: aSlotName [
	self assert: (self hasSlotDefinitionNamed: aSlotName) not.
	self assert: (self instVarNames includes: aSlotName) not.
	self assert: (self canUnderstand: aSlotName asSymbol) not.
	self assert: (self canUnderstand: (aSlotName , ':') asSymbol) not.
	self assert: (self class canUnderstand: (aSlotName , 'SlotDefinition') asSymbol) not
]

{ #category : #'slot model - verification' }
LcsDomainObject class >> assertSlotAdded: aSlotName [
	self assert: (self instVarNames includes: aSlotName).
	self assert: (self canUnderstand: aSlotName asSymbol).
	self assert: (self canUnderstand: (aSlotName , ':') asSymbol).
	self assert: (self class canUnderstand: (aSlotName , 'SlotDefinition') asSymbol)
]

{ #category : #'application environment' }
LcsDomainObject class >> currentSystem [
	^ LcsApplicationEnvironment currentSystem
]

{ #category : #'application environment' }
LcsDomainObject class >> currentUnitOfWork [
	^ LcsApplicationEnvironment currentUnitOfWork
]

{ #category : #'slot access' }
LcsDomainObject class >> getPersistedValueOf: aString in: anObject [ 
	^ self slotModel getPersistedValueOf: aString in: anObject 
]

{ #category : #'gt view' }
LcsDomainObject class >> gtViewSlotDefinitionFor: aView [
	<gtView>
	<gtClassView>
	"^ aView empty"
	^ aView columnedList
		title: 'Slot Definitions';
		priority: 3;
		items: [ self slotDefinitionPragmasAndInstVarNames ];
		column: 'Slot' text: [ :each | each value slotName ] width: 100;
		column: 'InstVar' text: [ :each | each key ] width: 100;
		column: 'Getter' text: [ :each | each value getterSelector ] width: 100;
		column: 'Setter' text: [ :each | each value setterSelector ] width: 100;
		column: '' stencil: [ :each | BrButton new
										aptitude: BrGlamorousButtonWithLabelAptitude new;
										label: 'Remove';
										action: [ :aButton | self domainClass removeDomainSlotNamed: each slotName ]] width: 70; 
		actionUpdateButton;
		send: #value;
		yourself
		
]

{ #category : #'gt view' }
LcsDomainObject class >> gtViewSlotModelFor: aView [
	<gtView>
	<gtClassView>
	self slotModel ifNil: [ 
		^ aView list
			title: 'Slot Model';
			priority: 2;
			items: [ Array with: 'Not initialized' ];
			yourself].	
	^ aView forward
		title: 'Slot Model';
		priority: 2;
		object: [ self slotModel ];
		view: #gtViewSlotModelFor:;
		yourself
		
]

{ #category : #testing }
LcsDomainObject class >> hasNoninitializedApplicationEnvironment [
	^ self isSlotModelReleased
]

{ #category : #testing }
LcsDomainObject class >> hasNoninitializedSlotModel [
	^ self hasNoninitializedApplicationEnvironment
]

{ #category : #testing }
LcsDomainObject class >> hasParentSlotDefinition [
	^ self hasSlotDefinitionNamed: 'parent' 
]

{ #category : #testing }
LcsDomainObject class >> hasSlotDefinitionNamed: aString [ 
	self slotModel ifNil: [ ^ false ].
	^ self slotModel hasSlotDefinitionNamed: aString
]

{ #category : #testing }
LcsDomainObject class >> hasSlotModel [
	^ self slotModel notNil 
]

{ #category : #'slot definitions' }
LcsDomainObject class >> historySlotDefinition [
	<slotDefinition>
	^ LcsCompositeSlot new
		slotName: 'history';
		addSlotType: LcsDomainObjectHistory;
		yourself
]

{ #category : #'application environment' }
LcsDomainObject class >> initializeApplicationEnvironment [
]

{ #category : #'slot model - install' }
LcsDomainObject class >> initializeSlotModel [
	self instantiateSlotModel.
	self installSlotModel
]

{ #category : #'slot model - install' }
LcsDomainObject class >> installSlotDefinition: aSlotDefinitionSelector [
	self slotModel addSlotDefinition: (self perform: aSlotDefinitionSelector)
]

{ #category : #'slot model - install' }
LcsDomainObject class >> installSlotDefinitions [
	self slotDefinitionPragmas do: [ :eachPragma | 
		self installSlotDefinition: eachPragma methodSelector ]
]

{ #category : #'slot model - install' }
LcsDomainObject class >> installSlotModel [
	self installSlotModelIn: self currentSystem
]

{ #category : #'slot model - install' }
LcsDomainObject class >> installSlotModelIn: aSystem [
	aSystem addToSlotModel: self slotModel.
	self installSlotDefinitions
]

{ #category : #'slot model - install' }
LcsDomainObject class >> instantiateSlotModel [
	self  verifySuperclassesHaveInitializedSlotModel.
	self slotModel: (LcsSlotModel newOn: self)
]

{ #category : #testing }
LcsDomainObject class >> isDomainClass [
	^true
]

{ #category : #testing }
LcsDomainObject class >> isPrototypeClass [
	^ self name beginsWith: 'Lxx'
]

{ #category : #testing }
LcsDomainObject class >> isRootDomainClass [
	^ self name asString = 'LcsDomainObject'
]

{ #category : #testing }
LcsDomainObject class >> isSlotModelInstantiated [
	^ self slotModel notNil
]

{ #category : #testing }
LcsDomainObject class >> isSlotModelPopulated [
	^ self isDefined and: [ 
		self subclasses allSatisfy: [ :each | each isSlotModelPopulated ] ]
]

{ #category : #testing }
LcsDomainObject class >> isSlotModelReleased [
	self withAllSubclassesDo: [ :eachClass | eachClass slotModel notNil ifTrue: [ ^ false ] ].
	^ true
]

{ #category : #'instance creation' }
LcsDomainObject class >> new [
	| newObject |
	newObject := self basicNew.
	self currentSystem ifNotNil: [ self addToUnitOfWork: newObject ].
	newObject initialize.
	^ newObject
]

{ #category : #'slot model' }
LcsDomainObject class >> parentSlot [
	^ self slotModel slotDefinitionNamed: 'parent'
]

{ #category : #'slot definitions' }
LcsDomainObject class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsParentSlot new
]

{ #category : #'application environment' }
LcsDomainObject class >> releaseApplicationEnvironment [
	self releaseSlotModel
]

{ #category : #'slot model' }
LcsDomainObject class >> releaseSlotModel [
	self slotModel: nil.
	self subclassesDo: [ :each | each releaseSlotModel ]
]

{ #category : #'slot definition - removal' }
LcsDomainObject class >> removeDomainSlotNamed: aSlotName [
	self slotModel removeSlotDefinitionNamed: aSlotName.
	self removeInstVar: aSlotName.
	self removeGetter: aSlotName asSymbol.
	self removeSetter: (aSlotName , ':') asSymbol.
	self removeSlotDefinition: (aSlotName , 'SlotDefinition') asSymbol
]

{ #category : #'slot definition - removal' }
LcsDomainObject class >> removeGetter: aGetter [
	self removeSelector: aGetter
]

{ #category : #'slot definition - removal' }
LcsDomainObject class >> removeInstVar: aSlotName [
	(self instVarNames includes: aSlotName)
		ifTrue: [ self removeInstVarNamed: aSlotName ]
]

{ #category : #'slot definition - removal' }
LcsDomainObject class >> removeSetter: aSetterSelector [
	self removeSelector: aSetterSelector
]

{ #category : #'slot definition - removal' }
LcsDomainObject class >> removeSlotDefinition: aSlotDefinitionSelector [
	self class removeSelector: aSlotDefinitionSelector
]

{ #category : #'slot model' }
LcsDomainObject class >> slotDefinitionNamed: aString [ 
	self verifySlotModelInitialized.
	^ self slotModel slotDefinitionNamed: aString
]

{ #category : #'slot model' }
LcsDomainObject class >> slotDefinitionPragmas [
	^ Pragma allNamed: 'slotDefinition' in: self class
]

{ #category : #'slot model' }
LcsDomainObject class >> slotDefinitionPragmasAndInstVarNames [
	" self slotDefinitionPragmasAndInstVarNames "
	| instVarNamesAndSlotDefinitions slotDefinition slotDefinitions |
	slotDefinitions := (self slotDefinitionPragmas collect: [ :eachPragma | self perform: eachPragma method selector ]) asOrderedCollection.
	instVarNamesAndSlotDefinitions := OrderedCollection new.
	self instVarNames do: [:eachName |
		slotDefinition := slotDefinitions
			detect: [ :eachSlotDefinition | eachSlotDefinition slotName = eachName ]
			ifNone: [ LcsSlotDefinition new slotName: 'missing' ].
		instVarNamesAndSlotDefinitions add: (Association key: eachName value: slotDefinition).
		slotDefinitions remove: slotDefinition ifAbsent: []].
	slotDefinitions do: [ :eachSlotDefinition |
		instVarNamesAndSlotDefinitions add: (
			(self classThatDefinesInstVarNamed: eachSlotDefinition slotName)
				ifNil: [ Association key: 'missing' value: eachSlotDefinition ]
				ifNotNil: [ :class | Association key: eachSlotDefinition slotName , '(' , class name asString , ')' value: eachSlotDefinition ]) ] .
	^ instVarNamesAndSlotDefinitions
]

{ #category : #accessing }
LcsDomainObject class >> slotModel [
	^ slotModel
]

{ #category : #accessing }
LcsDomainObject class >> slotModel: aSlotModel [
	slotModel := aSlotModel
]

{ #category : #'slot model' }
LcsDomainObject class >> slotModelNotInitializedError [
	LcsSlotModelNotInitializedError signalWithContext: self
]

{ #category : #'slot definitions' }
LcsDomainObject class >> uuidSlotDefinition [
	<slotDefinition>
	^ LcsUuidSlot new
]

{ #category : #'slot model - verification' }
LcsDomainObject class >> verifyClassHasDomainSlotNamed: aSlotName [
	self assert: (self allInstVarNames includes: aSlotName).
	self assert: (self canUnderstand: aSlotName asSymbol).
	self assert: (self canUnderstand: (aSlotName , ':') asSymbol).
	self assert: (self class canUnderstand: (aSlotName , 'SlotDefinition') asSymbol)
]

{ #category : #'slot model - verification' }
LcsDomainObject class >> verifyClassHasNoDomainSlotNamed: aSlotName [
	self assert: (self instVarNames includes: aSlotName) not.
	self assert: (self canUnderstand: aSlotName asSymbol) not.
	self assert: (self canUnderstand: (aSlotName , ':') asSymbol) not.
	self assert: (self class canUnderstand: (aSlotName , 'SlotDefinition') asSymbol) not
]

{ #category : #'slot model - verification' }
LcsDomainObject class >> verifyClassHasSlotDefinitionsForInstVars [
	self verifyNoSlotDefinitionInstanceVariableMismatch.
	self slotDefinitionPragmas do: [ :eachPragma |
		self verifyClassHasDomainSlotNamed: (self perform: eachPragma method selector) slotName]
]

{ #category : #'slot model - verification' }
LcsDomainObject class >> verifyNoSlotDefinitionInstanceVariableMismatch [
	| localInstVarNames slotDefinitions |
	localInstVarNames := self instVarNames asOrderedCollection.
	slotDefinitions := (self slotDefinitionPragmas collect: [ :eachPragma | self perform: eachPragma method selector ]) asOrderedCollection.
	slotDefinitions copy do: [ :eachSlotDefintion |
		(localInstVarNames includes: eachSlotDefintion slotName) 
			ifTrue: [
				slotDefinitions remove: eachSlotDefintion ifAbsent: [].
				localInstVarNames remove: eachSlotDefintion slotName]
			ifFalse: [
				(self classThatDefinesInstVarNamed: eachSlotDefintion slotName) notNil ifTrue: [
					slotDefinitions remove: eachSlotDefintion ifAbsent: [] ] ] ].
	(localInstVarNames notEmpty or: [slotDefinitions notEmpty]) ifTrue: [
		LcsSlotDefinitionAndInstanceVariableMismatchError signalFrom: self unmatchInstVars: localInstVarNames slotDefinitions: slotDefinitions]
]

{ #category : #'slot definition - removal' }
LcsDomainObject class >> verifyRemovedDomainSlotNamed: aSlotName [
	self slotModel ifNotNil: [
		self assert: (self slotModel _slotDefinitionNamed: aSlotName) isNil ].
	self assert: (self instVarNames includes: aSlotName) not.
	self assert: (self canUnderstand: aSlotName asSymbol) not.
	self assert: (self canUnderstand: (aSlotName , ':') asSymbol) not.
	self assert: (self class canUnderstand: (aSlotName , 'SlotDefinition') asSymbol) not.

]

{ #category : #'slot model - verification' }
LcsDomainObject class >> verifySlotModelConsistency [
	self logEntry.
	 self verifyClassHasSlotDefinitionsForInstVars .
	self assert: self hasSlotModel.
	self assert: self slotModel parent == self.
	self logExit.
]

{ #category : #'slot model - verification' }
LcsDomainObject class >> verifySlotModelInitialized [
	self slotModel ifNil: [ self slotModelNotInitializedError ]
]

{ #category : #'slot model - verification' }
LcsDomainObject class >> verifySuperclassesHaveInitializedSlotModel [
	"self superclass == LcsObject ifTrue: [ ^ self ].
	self superclass isSlotModelDefined
		ifFalse: [ LcsSlotModelNotInitializedError signalWithContext: self ].
	self superclass verifySuperclassesHaveInitializedSlotModel"

]

{ #category : #'slot definitions' }
LcsDomainObject class >> versionSlotDefinition [
	<slotDefinition>
	^ LcsSmallIntegerSlot new
		slotName: 'version';
		yourself
]

{ #category : #validation }
LcsDomainObject >> addValidateConfigurationResultTo: aValidator [
	"self isIncludedInSystemDomainClasses
		ifTrue: [self slotModel class name = #LcsSlotModel
					ifFalse: [ aValidator addIssueMessage: 'Slot Model not defined for ' , self className ]]"
	self slotModel isNil 
		ifTrue: [
			 aValidator addIssueMessage: 'Slot Model is not defined' ]
		ifFalse: [
			(self currentSystem systemSlotModel includes: self)
				ifFalse: [ aValidator addIssueMessage: 'Slot Model is defined but not in the systemSlotModel' ].
		aValidator validate: self slotModel]
]

{ #category : #'application environment' }
LcsDomainObject >> applicationEnvironment [
	^ self parent applicationEnvironment
]

{ #category : #'application environment' }
LcsDomainObject >> currentSystem [
	^ self class currentSystem
]

{ #category : #'application environment' }
LcsDomainObject >> currentUnitOfWork [
	^ self parent currentUnitOfWork
]

{ #category : #'unit of work' }
LcsDomainObject >> delete [

	self currentUnitOfWork deleteObject: self
]

{ #category : #'slot access' }
LcsDomainObject >> getPersistedValueOf: aString [
	^ self class getPersistedValueOf: aString in: self
]

{ #category : #'gt view' }
LcsDomainObject >> gtViewSlotDefinitionFor: aView [
	<gtView>
	<gtClassView>
	^ self class gtViewSlotDefinitionFor: aView
]

{ #category : #'gt view' }
LcsDomainObject >> gtViewSlotModelFor: aView [
	<gtView>
	<gtClassView>
	^ self class gtViewSlotModelFor: aView
]

{ #category : #accessing }
LcsDomainObject >> history [
	^ self slotVarNamed: 'history'
]

{ #category : #accessing }
LcsDomainObject >> history: anObject [
	self slotVarNamed: 'history' put: anObject
]

{ #category : #initialize }
LcsDomainObject >> initialize [
	super initialize.
	self initializeModel.
]

{ #category : #initialize }
LcsDomainObject >> initializeModel [
	self initializeSlotValues
]

{ #category : #'slot access' }
LcsDomainObject >> initializeSlotNamed: aSlotName [
	self slotModel initializeSlotNamed: aSlotName in: self
]

{ #category : #initialize }
LcsDomainObject >> initializeSlotValues [
	self verifySlotModelInitialized.
	self slotModel initializeSlotValuesIn: self
]

{ #category : #initialize }
LcsDomainObject >> initializeUninitializedSlotValues [
	self slotModel ifNil: [ LcsSlotModelNotInitializedError signalWithContext: self ].
	self slotModel initializeUnintializedSlotValuesIn: self.

]

{ #category : #'as yet unclassified' }
LcsDomainObject >> isAdding [
	"The object has been created but has not been committed. When committed the version will be incremented to 1"
	^ self version isZero
]

{ #category : #'as yet unclassified' }
LcsDomainObject >> isDeleted [
	^ self version = SmallInteger minVal
]

{ #category : #testing }
LcsDomainObject >> isDomainObject [
	^true
]

{ #category : #testing }
LcsDomainObject >> isIncludedInSystemDomainClasses [
	^ self currentSystem isIncludedInSystemDomainClasses: self
]

{ #category : #testing }
LcsDomainObject >> isMemberOfGlobalCollectionIn: aSlotName [
	^ self parentSlotDefinition isGlobalCollectionRefenceSlotTo: aSlotName
]

{ #category : #'as yet unclassified' }
LcsDomainObject >> isPendingDeletion [
	"This will only be -1 from the time the object is marked as deleted until the transaction is complete.
	 When the transaction is completed, the value of version with be low values"

	^ self version = -1
]

{ #category : #testing }
LcsDomainObject >> isRootDomainClass [
	self class isRootDomainClass
]

{ #category : #testing }
LcsDomainObject >> isSlotModelInstantiated [
	^ self class isSlotModelInstantiated
]

{ #category : #accessing }
LcsDomainObject >> parent [
	^ self slotVarNamed: 'parent'
]

{ #category : #accessing }
LcsDomainObject >> parent: anObject [
	self slotVarNamed: 'parent' put: anObject
]

{ #category : #'slot access' }
LcsDomainObject >> parentPersistedValue [
	^ self getPersistedValueOf: 'parent'
]

{ #category : #'slot model' }
LcsDomainObject >> parentSlot [
	^ self class parentSlot
]

{ #category : #'slot model' }
LcsDomainObject >> parentSlotDefinition [
	^ self slotModel parentSlotDefinition
]

{ #category : #'slot model' }
LcsDomainObject >> slotDefinitionNamed: aString [
	^ self class slotDefinitionNamed: aString
]

{ #category : #'slot model' }
LcsDomainObject >> slotModel [
	^ self class slotModel
]

{ #category : #'slot access' }
LcsDomainObject >> slotVarNamed: aSlotName [
	"Return the value of the instance variable in me with that name"
	^ (self slotDefinitionNamed: aSlotName) currentSlotVarIn: self
]

{ #category : #'slot access' }
LcsDomainObject >> slotVarNamed: aSlotName put: onObject [
	(self slotDefinitionNamed: aSlotName) slotVarPut: onObject in: self
]

{ #category : #accessing }
LcsDomainObject >> uuid [
	^ self slotVarNamed: 'uuid'
]

{ #category : #accessing }
LcsDomainObject >> uuid: anObject [
	self slotVarNamed: 'uuid' put: anObject
]

{ #category : #validation }
LcsDomainObject >> verifySlotModelInitialized [
	self class verifySlotModelInitialized
]

{ #category : #accessing }
LcsDomainObject >> version [
	^ self slotVarNamed: 'version'
]

{ #category : #accessing }
LcsDomainObject >> version: anObject [
	self slotVarNamed: 'version' put: anObject
]
