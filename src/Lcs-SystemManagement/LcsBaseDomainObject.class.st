Class {
	#name : #LcsBaseDomainObject,
	#superclass : #LcsObject,
	#instVars : [
		'parent'
	],
	#classInstVars : [
		'slotModel'
	],
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'meta data' }
LcsBaseDomainObject class >> addMyDomainClassHeirarchyTo: prebootstrapClasses [
	self allClassBetweenMyselfAndLcsDomainObject
		do: [ :each | (prebootstrapClasses includes: each) ifFalse: [ prebootstrapClasses add: each ] ].
	prebootstrapClasses add: self
]

{ #category : #'meta data' }
LcsBaseDomainObject class >> allClassBetweenMyselfAndLcsDomainObject [
	^ self allSuperclasses reverse
		reject: [ :each | (each inheritsFrom: LcsBaseDomainObject) not ]
]

{ #category : #'slot model - verification' }
LcsBaseDomainObject class >> assertDomainSlotRemoved: aSlotName [
	self assert: (self hasSlotDefinitionNamed: aSlotName) not.
	self assert: (self instVarNames includes: aSlotName) not.
	self assert: (self canUnderstand: aSlotName asSymbol) not.
	self assert: (self canUnderstand: (aSlotName , ':') asSymbol) not.
	self assert: (self class canUnderstand: (aSlotName , 'SlotDefinition') asSymbol) not
]

{ #category : #'slot model - verification' }
LcsBaseDomainObject class >> assertSlotAdded: aSlotName [
	self assert: (self instVarNames includes: aSlotName).
	self assert: (self canUnderstand: aSlotName asSymbol).
	self assert: (self canUnderstand: (aSlotName , ':') asSymbol).
	self assert: (self class canUnderstand: (aSlotName , 'SlotDefinition') asSymbol)
]

{ #category : #'application environment' }
LcsBaseDomainObject class >> currentSystem [
	^ LcsApplicationEnvironment currentSystem
]

{ #category : #'application environment' }
LcsBaseDomainObject class >> currentUnitOfWork [
	^ LcsApplicationEnvironment currentUnitOfWork
]

{ #category : #'slot access' }
LcsBaseDomainObject class >> getPersistedValueOf: aString in: anObject [ 
	^ self slotModel getPersistedValueOf: aString in: anObject 
]

{ #category : #'gt view' }
LcsBaseDomainObject class >> gtViewSlotDefinitionFor: aView [
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
		column: 'Type(s)' text: [ :each | each value slotTypesList ] width: 100;
		column: '' stencil: [ :each | BrButton new
										aptitude: BrGlamorousButtonWithLabelAptitude new;
										label: 'Remove';
										action: [ :aButton | self domainClass removeDomainSlotNamed: each slotName ]] width: 70; 
		actionUpdateButton;
		send: #value;
		yourself
		
]

{ #category : #'gt view' }
LcsBaseDomainObject class >> gtViewSlotModelFor: aView [
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
LcsBaseDomainObject class >> hasNoninitializedApplicationEnvironment [
	^ self isSlotModelReleased
]

{ #category : #testing }
LcsBaseDomainObject class >> hasNoninitializedSlotModel [
	^ self hasNoninitializedApplicationEnvironment
]

{ #category : #testing }
LcsBaseDomainObject class >> hasParentSlotDefinition [
	^ self hasSlotDefinitionNamed: 'parent' 
]

{ #category : #testing }
LcsBaseDomainObject class >> hasSlotDefinitionNamed: aString [ 
	self slotModel ifNil: [ ^ false ].
	^ self slotModel hasSlotDefinitionNamed: aString
]

{ #category : #testing }
LcsBaseDomainObject class >> hasSlotModel [
	^ self slotModel notNil 
]

{ #category : #'application environment' }
LcsBaseDomainObject class >> initializeApplicationEnvironment [
]

{ #category : #'slot model - install' }
LcsBaseDomainObject class >> initializeSlotModel [
	self instantiateSlotModel.
	self installSlotModel
]

{ #category : #'slot model - install' }
LcsBaseDomainObject class >> installSlotDefinition: aSlotDefinitionSelector [
	self slotModel addSlotDefinition: (self perform: aSlotDefinitionSelector)
]

{ #category : #'slot model - install' }
LcsBaseDomainObject class >> installSlotDefinitions [
	self slotDefinitionPragmas do: [ :eachPragma | 
		self installSlotDefinition: eachPragma methodSelector ]
]

{ #category : #'slot model - install' }
LcsBaseDomainObject class >> installSlotModel [
	self installSlotModelIn: self currentSystem
]

{ #category : #'slot model - install' }
LcsBaseDomainObject class >> installSlotModelIn: aSystem [
	aSystem addToSlotModel: self slotModel.
	self installSlotDefinitions
]

{ #category : #'slot model - install' }
LcsBaseDomainObject class >> instantiateSlotModel [
	self  verifySuperclassesHaveInitializedSlotModel.
	self slotModel: (LcsSlotModel newOn: self)
]

{ #category : #testing }
LcsBaseDomainObject class >> isDomainClass [
	^true
]

{ #category : #testing }
LcsBaseDomainObject class >> isPrototypeClass [
	^ self name beginsWith: 'Lxx'
]

{ #category : #testing }
LcsBaseDomainObject class >> isRootDomainClass [
	^ self name asString = 'LcsBaseDomainObject'
]

{ #category : #testing }
LcsBaseDomainObject class >> isSlotModelInstantiated [
	^ self slotModel notNil
]

{ #category : #testing }
LcsBaseDomainObject class >> isSlotModelPopulated [
	^ self isDefined and: [ 
		self subclasses allSatisfy: [ :each | each isSlotModelPopulated ] ]
]

{ #category : #testing }
LcsBaseDomainObject class >> isSlotModelReleased [
	self withAllSubclassesDo: [ :eachClass | eachClass slotModel notNil ifTrue: [ ^ false ] ].
	^ true
]

{ #category : #'instance creation' }
LcsBaseDomainObject class >> new [
	| newObject |
	newObject := self basicNew.
	newObject initialize.
	^ newObject
]

{ #category : #'slot model' }
LcsBaseDomainObject class >> parentSlot [
	^ self slotModel slotDefinitionNamed: 'parent'
]

{ #category : #'slot definitions' }
LcsBaseDomainObject class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsParentSlot new
]

{ #category : #'application environment' }
LcsBaseDomainObject class >> releaseApplicationEnvironment [
	self releaseSlotModel
]

{ #category : #'slot model' }
LcsBaseDomainObject class >> releaseSlotModel [
	self slotModel: nil.
	self subclassesDo: [ :each | each releaseSlotModel ]
]

{ #category : #'slot definition - removal' }
LcsBaseDomainObject class >> removeDomainSlotNamed: aSlotName [
	self slotModel removeSlotDefinitionNamed: aSlotName.
	self removeInstVar: aSlotName.
	self removeGetter: aSlotName asSymbol.
	self removeSetter: (aSlotName , ':') asSymbol.
	self removeSlotDefinition: (aSlotName , 'SlotDefinition') asSymbol
]

{ #category : #'slot definition - removal' }
LcsBaseDomainObject class >> removeGetter: aGetter [
	self removeSelector: aGetter
]

{ #category : #'slot definition - removal' }
LcsBaseDomainObject class >> removeInstVar: aSlotName [
	(self instVarNames includes: aSlotName)
		ifTrue: [ self removeInstVarNamed: aSlotName ]
]

{ #category : #'slot definition - removal' }
LcsBaseDomainObject class >> removeSetter: aSetterSelector [
	self removeSelector: aSetterSelector
]

{ #category : #'slot definition - removal' }
LcsBaseDomainObject class >> removeSlotDefinition: aSlotDefinitionSelector [
	self class removeSelector: aSlotDefinitionSelector
]

{ #category : #'slot model' }
LcsBaseDomainObject class >> slotDefinitionNamed: aString [ 
	self verifySlotModelInitialized.
	^ self slotModel slotDefinitionNamed: aString
]

{ #category : #'slot model' }
LcsBaseDomainObject class >> slotDefinitionPragmas [
	^ Pragma allNamed: 'slotDefinition' in: self class
]

{ #category : #'slot model' }
LcsBaseDomainObject class >> slotDefinitionPragmasAndInstVarNames [
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
LcsBaseDomainObject class >> slotModel [
	^ slotModel
]

{ #category : #accessing }
LcsBaseDomainObject class >> slotModel: aSlotModel [
	slotModel := aSlotModel
]

{ #category : #'slot model' }
LcsBaseDomainObject class >> slotModelNotInitializedError [
	LcsSlotModelNotInitializedError signalWithContext: self
]

{ #category : #'slot model - verification' }
LcsBaseDomainObject class >> verifyClassHasDomainSlotNamed: aSlotName [
	self assert: (self allInstVarNames includes: aSlotName).
	self assert: (self canUnderstand: aSlotName asSymbol).
	self assert: (self canUnderstand: (aSlotName , ':') asSymbol).
	self assert: (self class canUnderstand: (aSlotName , 'SlotDefinition') asSymbol)
]

{ #category : #'slot model - verification' }
LcsBaseDomainObject class >> verifyClassHasNoDomainSlotNamed: aSlotName [
	self assert: (self instVarNames includes: aSlotName) not.
	self assert: (self canUnderstand: aSlotName asSymbol) not.
	self assert: (self canUnderstand: (aSlotName , ':') asSymbol) not.
	self assert: (self class canUnderstand: (aSlotName , 'SlotDefinition') asSymbol) not
]

{ #category : #'slot model - verification' }
LcsBaseDomainObject class >> verifyClassHasSlotDefinitionsForInstVars [
	self verifyNoSlotDefinitionInstanceVariableMismatch.
	self slotDefinitionPragmas do: [ :eachPragma |
		self verifyClassHasDomainSlotNamed: (self perform: eachPragma method selector) slotName]
]

{ #category : #'slot model - verification' }
LcsBaseDomainObject class >> verifyNoSlotDefinitionInstanceVariableMismatch [
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
LcsBaseDomainObject class >> verifyRemovedDomainSlotNamed: aSlotName [
	self slotModel ifNotNil: [
		self assert: (self slotModel _slotDefinitionNamed: aSlotName) isNil ].
	self assert: (self instVarNames includes: aSlotName) not.
	self assert: (self canUnderstand: aSlotName asSymbol) not.
	self assert: (self canUnderstand: (aSlotName , ':') asSymbol) not.
	self assert: (self class canUnderstand: (aSlotName , 'SlotDefinition') asSymbol) not.

]

{ #category : #'slot model - verification' }
LcsBaseDomainObject class >> verifySlotModelConsistency [
	 self verifyClassHasSlotDefinitionsForInstVars .
	self assert: self hasSlotModel.
	self assert: self slotModel parent == self
]

{ #category : #'slot model - verification' }
LcsBaseDomainObject class >> verifySlotModelInitialized [
	self slotModel ifNil: [ self slotModelNotInitializedError ]
]

{ #category : #'slot model - verification' }
LcsBaseDomainObject class >> verifySuperclassesHaveInitializedSlotModel [
	"self superclass == LcsObject ifTrue: [ ^ self ].
	self superclass isSlotModelDefined
		ifFalse: [ LcsSlotModelNotInitializedError signalWithContext: self ].
	self superclass verifySuperclassesHaveInitializedSlotModel"

]

{ #category : #validation }
LcsBaseDomainObject >> addValidateConfigurationResultTo: aValidator [
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
LcsBaseDomainObject >> applicationEnvironment [
	^ self parent applicationEnvironment
]

{ #category : #'application environment' }
LcsBaseDomainObject >> currentSystem [
	^ self class currentSystem
]

{ #category : #'application environment' }
LcsBaseDomainObject >> currentUnitOfWork [
	^ self parent currentUnitOfWork
]

{ #category : #'slot access' }
LcsBaseDomainObject >> getPersistedValueOf: aString [
	^ self class getPersistedValueOf: aString in: self
]

{ #category : #'gt view' }
LcsBaseDomainObject >> gtViewSlotDefinitionFor: aView [
	<gtView>
	<gtClassView>
	^ self class gtViewSlotDefinitionFor: aView
]

{ #category : #'gt view' }
LcsBaseDomainObject >> gtViewSlotModelFor: aView [
	<gtView>
	<gtClassView>
	^ self class gtViewSlotModelFor: aView
]

{ #category : #initialize }
LcsBaseDomainObject >> initialize [
	super initialize.
	self initializeModel.
]

{ #category : #initialize }
LcsBaseDomainObject >> initializeModel [
	self initializeSlotValues
]

{ #category : #'slot access' }
LcsBaseDomainObject >> initializeSlotNamed: aSlotName [
	self slotModel initializeSlotNamed: aSlotName in: self
]

{ #category : #initialize }
LcsBaseDomainObject >> initializeSlotValues [
	self verifySlotModelInitialized.
	self slotModel initializeSlotValuesIn: self
]

{ #category : #initialize }
LcsBaseDomainObject >> initializeUninitializedSlotValues [
	self slotModel ifNil: [ LcsSlotModelNotInitializedError signalWithContext: self ].
	self slotModel initializeUnintializedSlotValuesIn: self.

]

{ #category : #testing }
LcsBaseDomainObject >> isDomainObject [
	^true
]

{ #category : #testing }
LcsBaseDomainObject >> isIncludedInSystemDomainClasses [
	^ self currentSystem isIncludedInSystemDomainClasses: self
]

{ #category : #testing }
LcsBaseDomainObject >> isMemberOfGlobalCollectionIn: aSlotName [
	^ self parentSlotDefinition isGlobalCollectionRefenceSlotTo: aSlotName
]

{ #category : #testing }
LcsBaseDomainObject >> isRootDomainClass [
	self class isRootDomainClass
]

{ #category : #testing }
LcsBaseDomainObject >> isSlotModelInstantiated [
	^ self class isSlotModelInstantiated
]

{ #category : #accessing }
LcsBaseDomainObject >> parent [
	^ self slotVarNamed: 'parent'
]

{ #category : #accessing }
LcsBaseDomainObject >> parent: anObject [
	self slotVarNamed: 'parent' put: anObject
]

{ #category : #'slot access' }
LcsBaseDomainObject >> parentPersistedValue [
	^ self getPersistedValueOf: 'parent'
]

{ #category : #'slot model' }
LcsBaseDomainObject >> parentSlot [
	^ self class parentSlot
]

{ #category : #'slot model' }
LcsBaseDomainObject >> parentSlotDefinition [
	^ self slotModel parentSlotDefinition
]

{ #category : #'slot model' }
LcsBaseDomainObject >> slotDefinitionNamed: aString [
	^ self class slotDefinitionNamed: aString
]

{ #category : #'slot model' }
LcsBaseDomainObject >> slotModel [
	^ self class slotModel
]

{ #category : #'slot access' }
LcsBaseDomainObject >> slotVarNamed: aSlotName [
	"Return the value of the instance variable in me with that name"
	^ (self slotDefinitionNamed: aSlotName) currentSlotVarIn: self
]

{ #category : #'slot access' }
LcsBaseDomainObject >> slotVarNamed: aSlotName put: onObject [
	(self slotDefinitionNamed: aSlotName) slotVarPut: onObject in: self
]

{ #category : #validation }
LcsBaseDomainObject >> verifySlotModelInitialized [
	self class verifySlotModelInitialized
]
