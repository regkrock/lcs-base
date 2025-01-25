Class {
	#name : #LcsDomainObject,
	#superclass : #LcsObject,
	#instVars : [
		'parent'
	],
	#classInstVars : [
		'slotModel'
	],
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'slot model' }
LcsDomainObject class >> _installSlotDefinition: aSlotDefinitionSelector [
	^ self slotModel addSlotDefinition: (self perform: aSlotDefinitionSelector)
]

{ #category : #initialize }
LcsDomainObject class >> addMyDomainClassHeirarchyTo: prebootstrapClasses [
	self allClassBetweenMyselfAndLcsDomainObject
		do: [ :each | prebootstrapClasses add: each ].
	prebootstrapClasses add: self
]

{ #category : #'slot model' }
LcsDomainObject class >> addPrototypeClassTo: classes [ 
	self isPrototypeClass ifTrue: [ classes add: self ] 
]

{ #category : #'unit of work' }
LcsDomainObject class >> addToUnitOfWork: newObject [
	self currentUnitOfWork addObject: newObject
]

{ #category : #initialize }
LcsDomainObject class >> allClassBetweenMyselfAndLcsDomainObject [
	^ self allSuperclasses reverse
		reject: [ :each | (each inheritsFrom: LcsDomainObject) not ]
]

{ #category : #'slot model' }
LcsDomainObject class >> assertDomainSlotRemoved: aSlotName [
	self assert: (self hasSlotDefinitionNamed: aSlotName) not.
	self assert: (self instVarNames includes: aSlotName) not.
	self assert: (self canUnderstand: aSlotName asSymbol) not.
	self assert: (self canUnderstand: (aSlotName , ':') asSymbol) not.
	self assert: (self class canUnderstand: (aSlotName , 'SlotDefinition') asSymbol) not
]

{ #category : #'slot model' }
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

{ #category : #'slot definitions' }
LcsDomainObject class >> getPersistedValueOf: aString in: anObject [ 
	^ self slotModel getPersistedValueOf: aString in: anObject 
]

{ #category : #'gt view' }
LcsDomainObject class >> gtViewSlotDefinitionFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Slot Definitions';
		priority: 3;
		items: [ self slotDefinitionPragmasAndInstVarNames ];
		column: 'Slot' text: [ :each | each value slotName ] width: 100;
		column: 'InstVar' text: [ :each | each key ] width: 100;
		column: 'Getter' text: [ :each | each value getterSelector ] width: 100;
		column: 'Setter' text: [ :each | each value setterSelector ] width: 100;
		"column: '' stencil: [ :each | BrButton new
										aptitude: BrGlamorousButtonWithLabelAptitude new;
										label: 'Remove';
										action: [ :aButton | self domainClass removeDomainSlotNamed: each slotName ]] width: 70; "
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

{ #category : #'slot model' }
LcsDomainObject class >> hasParentSlotDefinition [
	^ self hasSlotDefinitionNamed: 'parent' 
]

{ #category : #'slot model' }
LcsDomainObject class >> hasSlotDefinitionNamed: aString [ 
	self slotModel ifNil: [ ^ false ].
	^ self slotModel hasSlotDefinitionNamed: aString
]

{ #category : #'application environment' }
LcsDomainObject class >> initializeApplicationEnvironment [
]

{ #category : #'slot model' }
LcsDomainObject class >> initializeSlotModel [
	self instantiateSlotModel.
	self installSlotModel
]

{ #category : #'slot model' }
LcsDomainObject class >> installSlotDefinition: aSlotDefinitionSelector [
	self slotModel addSlotDefinition: (self perform: aSlotDefinitionSelector)
]

{ #category : #'slot model' }
LcsDomainObject class >> installSlotDefinitions [
	self slotDefinitionPragmas do: [ :eachPragma | 
		self installSlotDefinition: eachPragma methodSelector ]
]

{ #category : #'slot model' }
LcsDomainObject class >> installSlotModel [
	self installSlotModelIn: self currentSystem
]

{ #category : #'slot model' }
LcsDomainObject class >> installSlotModelIn: aSystem [
	aSystem addToSlotModel: self slotModel.
	self installSlotDefinitions
]

{ #category : #'slot model' }
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
LcsDomainObject class >> isSlotModelDefined [
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

{ #category : #'slot definition' }
LcsDomainObject class >> parentSlot [
	^ self slotModel slotDefinitionNamed: 'parent'
]

{ #category : #'slot definition' }
LcsDomainObject class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsParentSlot new
]

{ #category : #'slot definition' }
LcsDomainObject class >> parentSlotSlotDefinition [
	^ self slotModel slotDefinitionNamed: 'parent'
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

{ #category : #'slot model' }
LcsDomainObject class >> removeDomainSlotNamed: aSlotName [
	self slotModel removeSlotDefinitionNamed: aSlotName.
	self removeInstVar: aSlotName.
	self removeGetter: aSlotName asSymbol.
	self removeSetter: (aSlotName , ':') asSymbol.
	self removeSlotDefinition: (aSlotName , 'SlotDefinition') asSymbol
]

{ #category : #'slot model' }
LcsDomainObject class >> removeGetter: aGetter [
	self removeSelector: aGetter
]

{ #category : #'slot model' }
LcsDomainObject class >> removeInstVar: aSlotName [
	(self instVarNames includes: aSlotName)
		ifTrue: [ self removeInstVarNamed: aSlotName ]
]

{ #category : #'slot model' }
LcsDomainObject class >> removeSetter: aSetterSelector [
	self removeSelector: aSetterSelector
]

{ #category : #'slot model' }
LcsDomainObject class >> removeSlotDefinition: aSlotDefinitionSelector [
	self class removeSelector: aSlotDefinitionSelector
]

{ #category : #'slot model' }
LcsDomainObject class >> restorelotModel [
	self initializeSlotModel
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

{ #category : #'slot model' }
LcsDomainObject class >> verifyClassHasDomainSlotNamed: aSlotName [
	self assert: (self allInstVarNames includes: aSlotName).
	self assert: (self canUnderstand: aSlotName asSymbol).
	self assert: (self canUnderstand: (aSlotName , ':') asSymbol).
	self assert: (self class canUnderstand: (aSlotName , 'SlotDefinition') asSymbol)
]

{ #category : #'slot model' }
LcsDomainObject class >> verifyClassHasNoDomainSlotNamed: aSlotName [
	self assert: (self instVarNames includes: aSlotName) not.
	self assert: (self canUnderstand: aSlotName asSymbol) not.
	self assert: (self canUnderstand: (aSlotName , ':') asSymbol) not.
	self assert: (self class canUnderstand: (aSlotName , 'SlotDefinition') asSymbol) not
]

{ #category : #'slot model' }
LcsDomainObject class >> verifyClassHasSlotDefinitionsForInstVars [
	self verifyNoSlotDefinitionInstanceVariableMismatch.
	self slotDefinitionPragmas do: [ :eachPragma |
		self verifyClassHasDomainSlotNamed: (self perform: eachPragma method selector) slotName]
]

{ #category : #'slot model' }
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
	self assert: localInstVarNames isEmpty description: self class name , ' has instance variable(s) which have not slot definition'.
	self assert: slotDefinitions isEmpty description: self class name , ' has slot definition(s) without a corresponding instance variable name(s)'
]

{ #category : #'slot model' }
LcsDomainObject class >> verifySlotModelConsistency [
	 self verifyClassHasSlotDefinitionsForInstVars .
	self assert: self isSlotModelDefined.
	self assert: self slotModel parent == self.

]

{ #category : #'slot model' }
LcsDomainObject class >> verifySlotModelInitialized [
	self slotModel ifNil: [ self slotModelNotInitializedError ]
]

{ #category : #'slot model' }
LcsDomainObject class >> verifySuperclassesHaveInitializedSlotModel [
	self superclass == LcsObject ifTrue: [ ^ self ].
	self superclass isSlotModelDefined
		ifFalse: [ LcsSlotModelNotInitializedError signalWithContext: self ].
	self superclass verifySuperclassesHaveInitializedSlotModel

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

{ #category : #system }
LcsDomainObject >> currentSystem [
	^ self class currentSystem
]

{ #category : #system }
LcsDomainObject >> currentUnitOfWork [
	^ self parent currentUnitOfWork
]

{ #category : #'unit of work' }
LcsDomainObject >> delete [

	self currentUnitOfWork deleteObject: self
]

{ #category : #'slot definitions' }
LcsDomainObject >> getPersistedValueOf: aString [
	^ self class getPersistedValueOf: aString in: self
]

{ #category : #'slot definitions' }
LcsDomainObject >> getValueOfSlotNamed: aSlotName [
	^ (self slotDefinitionNamed: aSlotName) getValueIn: self
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

{ #category : #iniitialize }
LcsDomainObject >> initialize [
	super initialize.
	self initializeModel.
]

{ #category : #iniitialize }
LcsDomainObject >> initializeModel [
	self initializeSlotValues
]

{ #category : #'slot model' }
LcsDomainObject >> initializeSlotNamed: aSlotName [
	self slotModel initializeSlotNamed: aSlotName in: self
]

{ #category : #iniitialize }
LcsDomainObject >> initializeSlotValues [
	self verifySlotModelInitialized.
	self slotModel initializeSlotValuesIn: self
]

{ #category : #iniitialize }
LcsDomainObject >> initializeUninitializedSlotValues [
	self slotModel ifNil: [ LcsSlotModelNotInitializedError signalWithContext: self ].
	self slotModel initializeUnintializedSlotValuesIn: self.

]

{ #category : #testing }
LcsDomainObject >> isDomainObject [
	^true
]

{ #category : #validation }
LcsDomainObject >> isIncludedInSystemDomainClasses [
	^ self currentSystem isIncludedInSystemDomainClasses: self
]

{ #category : #testing }
LcsDomainObject >> isMemberOfGlobalCollectionIn: aSlotName [
	^ self parentSlotDefinition isGlobalCollectionRefenceSlotTo: aSlotName
]

{ #category : #accessing }
LcsDomainObject >> isRootDomainClass [
	self class isRootDomainClass
]

{ #category : #accessing }
LcsDomainObject >> parent [
	^ self getValueOfSlotNamed: 'parent'
]

{ #category : #accessing }
LcsDomainObject >> parent: anObject [
	self setValueOfSlotNamed: 'parent' to: anObject
]

{ #category : #accessing }
LcsDomainObject >> parentPersistedValue [
	^ self getPersistedValueOf: 'parent'
]

{ #category : #accessing }
LcsDomainObject >> parentSlot [
	^ self class parentSlot
]

{ #category : #'slot model' }
LcsDomainObject >> parentSlotDefinition [
	^ self slotModel parentSlotDefinition
]

{ #category : #'slot definitions' }
LcsDomainObject >> setValueOfSlotNamed: aSlotName to: onObject [
	(self slotDefinitionNamed: aSlotName) setValueTo: onObject in: self
]

{ #category : #'slot definitions' }
LcsDomainObject >> slotDefinitionNamed: aString [
	^ self class slotDefinitionNamed: aString
]

{ #category : #'slot definitions' }
LcsDomainObject >> slotModel [
	^ self class slotModel
]

{ #category : #iniitialize }
LcsDomainObject >> verifySlotModelInitialized [
	self class verifySlotModelInitialized
]
