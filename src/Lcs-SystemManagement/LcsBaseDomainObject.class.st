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

{ #category : #'slot model' }
LcsBaseDomainObject class >> accessorSlotDefinitionPragmas [
	^ Pragma allNamed: 'slotDefinition' in: self class
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

{ #category : #'slot model' }
LcsBaseDomainObject class >> facadeSlotDefinitionPragmas [
	^ Pragma allNamed: 'facadeSlotDefinition' in: self class
]

{ #category : #'slot access' }
LcsBaseDomainObject class >> getPersistedValueOf: aString in: anObject [ 
	^ self slotModel getPersistedValueOf: aString in: anObject 
]

{ #category : #'gt views' }
LcsBaseDomainObject class >> gtSlotDefinitionMethodFor: aView [
	<gtClassView>
	^ aView explicit
		title: 'Slot Defn Methods';
		tooltip: 'Methods that define Slot Defintions';
		priority: 100;
		stencil: [ (self class gtMethodsInClass includeSuperclass: true)
				& ( #slotDefinition gtPragmas "| #magritteActionDescription gtPragmas") ];
		actionUpdateButton
		
]

{ #category : #'gt views' }
LcsBaseDomainObject class >> gtViewSlotDefinitionFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Slot Definitions';
		priority: 19;
		items: [ self slotDefinitionViewItems ];
		column: 'Slot' text: [ :each | each slotName ] width: 100;
		column: 'Kind' text: [ :each | each slotKind ] width: 70;
		column: 'InstVar' text: [ :each | each instVarName ] width: 100;
		column: 'Getter' text: [ :each | each getterSelector ] width: 100;
		column: 'Setter' text: [ :each | each setterSelector ] width: 100;
		column: 'Priority' text: [ :each | each priority ] width: 30;
		column: 'Type(s)' text: [ :each | each slotTypesList ] width: 100;
		column: 'Class' text: [ :each | each domainClass name ] width: 100;
		column: '' stencil: [ :each | 
			BrButton new
				aptitude: BrGlamorousButtonWithLabelAptitude new;
				label: 'Remove';
				action: [ :aButton | 
					each remove.
					aButton phlow fireViewUpdateWish ]] width: 70; 
		actionButtonDo: [ :aButtonAction | 
			aButtonAction
				icon: BrGlamorousVectorIcons spawn;
				tooltip: 'Create slot';
				action: [ :aButton | aButton phlow spawnObject: (LcsAccessorSlotCreationForm newEditOn: self)  ] ];
		actionUpdateButton;
		send: [ :each | each slotDefinitionInformation ] ;
		yourself
		
]

{ #category : #'gt views' }
LcsBaseDomainObject class >> gtViewSlotModelFor: aView [
	<gtView>
	<gtClassView>
	self slotModel ifNil: [ 
		^ aView list
			title: 'Slot Model';
			priority: 10;
			items: [ Array with: 'Not initialized' ];
			yourself].	
	^ aView forward
		title: 'Slot Model';
		priority: 10;
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
LcsBaseDomainObject class >> installFacadeSlotDefinition: aSlotDefinitionSelector [
	self currentSystem isNil ifTrue: [ ^ self ].
	self slotModel addFacadeSlotDefinition: (self perform: aSlotDefinitionSelector)
]

{ #category : #'slot model - install' }
LcsBaseDomainObject class >> installSlotDefinition: aSlotDefinitionSelector [
	self currentSystem isNil ifTrue: [ ^ self ].
	self slotModel addSlotDefinition: (self perform: aSlotDefinitionSelector)
]

{ #category : #'slot model - install' }
LcsBaseDomainObject class >> installSlotDefinitions [
	self slotDefinitionPragmas
		do: [ :eachPragma | self installSlotDefinition: eachPragma methodSelector ].
	self virtualSlotDefinitionPragmas
		do: [ :eachPragma | self installVirtualSlotDefinition: eachPragma methodSelector ].
	self facadeSlotDefinitionPragmas
		do: [ :eachPragma | self installFacadeSlotDefinition: eachPragma methodSelector ]
]

{ #category : #'slot model - install' }
LcsBaseDomainObject class >> installSlotModel [
	self currentSystem notNil ifTrue: [
		self installSlotModelIn: self currentSystem ]
]

{ #category : #'slot model - install' }
LcsBaseDomainObject class >> installSlotModelIn: aSystem [
	aSystem addToSlotModel: self slotModel.
	self installSlotDefinitions
]

{ #category : #'slot model - install' }
LcsBaseDomainObject class >> installVirtualSlotDefinition: aSlotDefinitionSelector [
	self currentSystem isNil ifTrue: [ ^ self ].
	self slotModel addVirtualSlotDefinition: (self perform: aSlotDefinitionSelector)
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
	self slotModel isNil ifTrue: [ LcsUndefinedSlotModelError signalClassWithoutSlotModel: self ].
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
	self removeDomainSlotNamedFromSlotModel: aSlotName.
	self removeInstVar: aSlotName.
	self removeGetter: aSlotName.
	self removeSetter: (aSlotName , ':').
	self removeSlotDefinition: (aSlotName , 'SlotDefinition')
]

{ #category : #'slot definition - removal' }
LcsBaseDomainObject class >> removeDomainSlotNamedFromSlotModel: aSlotName [
	self slotModel
		ifNotNil: [ :model | model removeSlotDefinitionNamed: aSlotName asString ]
]

{ #category : #'slot definition - removal' }
LcsBaseDomainObject class >> removeGetter: aGetter [
	self removeSelector: aGetter asSymbol
]

{ #category : #'slot definition - removal' }
LcsBaseDomainObject class >> removeInstVar: aSlotName [
	(self instVarNames includes: aSlotName asSymbol)
		ifTrue: [ self removeInstVarNamed: aSlotName asSymbol ]
]

{ #category : #'slot definition - removal' }
LcsBaseDomainObject class >> removeSetter: aSetterSelector [
	self removeSelector: aSetterSelector asSymbol
]

{ #category : #'slot definition - removal' }
LcsBaseDomainObject class >> removeSlotDefinition: aSlotDefinitionSelector [
	self class removeSelector: aSlotDefinitionSelector asSymbol
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
LcsBaseDomainObject class >> slotDefinitionViewItems [
	" self slotDefinitionPragmasAndInstVarNames "
	| slotDefinitionViewItems accessorSlotDefinitionViewItems allInstVarNames localInstVarNames|
	slotDefinitionViewItems := (self accessorSlotDefinitionPragmas collect: [ :eachPragma | 
		LcsExtantSlotDefinitionViewItem on: ((self perform: eachPragma method selector) domainClass: self) ]) asOrderedCollection.
	accessorSlotDefinitionViewItems := slotDefinitionViewItems select: [ :each | each isAccessorSlot ].
	allInstVarNames := self allInstVarNames.
	localInstVarNames := self instVarNames asOrderedCollection.
	localInstVarNames copy do: [:eachInstVarName |
		accessorSlotDefinitionViewItems 
			detect: [ :eachSlotDefinitionViewItem | 
				eachSlotDefinitionViewItem slotName asSymbol = eachInstVarName 
					ifTrue: [ 
						eachSlotDefinitionViewItem instVarName: eachInstVarName.
						localInstVarNames remove: eachInstVarName ifAbsent: [].
						true ]
					ifFalse: [  false ] ]
			ifNone: [ slotDefinitionViewItems add: (LcsMissingSlotDefinitionViewItem on: eachInstVarName domainClass: self) ] ].
	(accessorSlotDefinitionViewItems select: [ :each | each instVarName isEmptyOrNil])
		do: [ :each | (allInstVarNames includes: each slotName asSymbol) ifTrue: [ each instVarName: each slotName asSymbol  ]].
	^ slotDefinitionViewItems
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

{ #category : #'gt views' }
LcsBaseDomainObject class >> slotNamesExcludedFromCollectionViewSlotDefinitions [
	^ #('parent')
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
	slotDefinitions := (self accessorSlotDefinitionPragmas collect: [ :eachPragma | self perform: eachPragma method selector ]) asOrderedCollection.
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

{ #category : #'slot model' }
LcsBaseDomainObject class >> virtualSlotDefinitionPragmas [
	^ Pragma allNamed: 'virtualSlotDefinition' in: self class
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
			(self currentSystem systemSlotModel hasSlotModelFor: self)
				ifFalse: [ aValidator addIssueMessage: 'Slot Model is defined but not in the systemSlotModel' ].
		aValidator validate: self slotModel]
]

{ #category : #'slot model' }
LcsBaseDomainObject >> allSlotDefinitions [
	^ self slotModel allSlotDefinitions
]

{ #category : #'application environment' }
LcsBaseDomainObject >> applicationEnvironment [
	^ self parent applicationEnvironment
]

{ #category : #validation }
LcsBaseDomainObject >> auditSlots [
	<TODO: 'This needs more work'>
	| auditor |
	auditor :=  LcsConditionsValidator newOn: self.
	self slotModel audit: self withAuditor: auditor.
	^ auditor
]

{ #category : #'slot model' }
LcsBaseDomainObject >> changeRecordForSlot: aSlotName [
	^ (self slotDefinitionNamed: aSlotName) changedSlotRecordFor: self
]

{ #category : #'slot model' }
LcsBaseDomainObject >> changeValueForSlot: aSlotName [
	^ (self changeRecordForSlot: aSlotName) ifNil: [ '' ] ifNotNil: [ :slotChangeRecord | slotChangeRecord newValue]
]

{ #category : #'slot model' }
LcsBaseDomainObject >> collectionViewSlotDefinitions [
	^ self slotModel collectionViewSlotDefinitions
]

{ #category : #'application environment' }
LcsBaseDomainObject >> currentSystem [
	^ self class currentSystem
]

{ #category : #'application environment' }
LcsBaseDomainObject >> currentUnitOfWork [
	^ self class currentUnitOfWork
]

{ #category : #'application environment' }
LcsBaseDomainObject >> currentUser [
	^ self currentSystem currentUser
]

{ #category : #'slot access' }
LcsBaseDomainObject >> getPersistedValueOf: aString [
	^ self class getPersistedValueOf: aString in: self
]

{ #category : #'gt views' }
LcsBaseDomainObject >> gtRawFor: aView [
	<gtView>
	self currentSystem ifNil: [ ^ super gtRawFor: aView ].
	self currentSystem unitOfWork isNil ifTrue: [ ^ super gtRawFor: aView ].
	"(self currentSystem unitOfWork hasChangeRecordFor: self) 
		ifFalse: [ ^ super gtRawFor: aView ]."
	^ aView columnedTree
		title: 'Raw';
		priority: 100;
		items: [ | variableNodes |
			variableNodes := OrderedCollection new: self class allSlots size.
			variableNodes add: (GtInspectorSelfNode hostObject: self).
			self gtInspectorVariableNodesIn: variableNodes.
			variableNodes ];
		children: [ :aNode | aNode childrenNodes ];
		column: 'Variable'
			do: [ :aColumn | 
				aColumn
					cellStencil: [ BrHorizontalPane new
							hMatchParent;
							vFitContent;
							alignCenter ];
					dataBinder: [ :itemElement :aNode | 
						| nodeIcon |
						nodeIcon := [ aNode rawValue gtInspectorIcon
								ifNil: [ aNode rawValue class iconNamed: aNode rawValue class systemIconName ] ]
								on: Error
								do: [ :error | Smalltalk ui icons iconNamed: #smallWarningIcon ].

						itemElement
							removeChildren;
							addChild: nodeIcon asElement;
							addChild: (BrLabel new
									aptitude: BrGlamorousListLabelAptitude;
									text: aNode label;
									alignCenterLeft;
									hMatchParent;
									vFitContent) ] ];
		column: 'Value'
			text: [ :aNode | 
				[ aNode rawValue gtDisplayText ]
					on: Error , Halt
					do: [ aNode errorMessage asRopedText foreground: Color red ] ];
		column: 'Pending Change'
			text: [ :aNode | 
				[ aNode ifNil: [ '' ] ifNotNil: [
					(aNode class canUnderstand: #changeValue) 
						ifTrue: [ aNode changeValue gtDisplayText ] 
						ifFalse: [ '' ] ] ] 
					on: Error , Halt
					do: [ aNode errorMessage asRopedText foreground: Color red ] ];
		send: [ :eaRow | 
			eaRow changeValue notNil ifTrue: [ eaRow changeValue ] ifFalse: [ eaRow rawValue ] ];
		dynamicContextItems: [ :aTreeNode | 
			aTreeNode value isSlotNode
				ifTrue: [ (GtViewCreator
						viewCreatorsForObject: aTreeNode value rawValue
						andSource: aTreeNode value key
						in: aTreeNode value hostObject class)
						collect: [ :creator | 
							creator selfObject: self.
							creator asMenuItem ] ]
				ifFalse: [ #() ] ];
		actionUpdateButton
]

{ #category : #'gt views' }
LcsBaseDomainObject >> gtViewSlotDefinitionFor: aView [
	<gtView>
	<gtClassView>
	^ self class gtViewSlotDefinitionFor: aView
]

{ #category : #'gt views' }
LcsBaseDomainObject >> gtViewSlotModelFor: aView [
	<gtView>
	<gtClassView>
	^ self class gtViewSlotModelFor: aView
]

{ #category : #'unit of work' }
LcsBaseDomainObject >> incrementVersionNumber [
	"subclasses should implement as needed"
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
	^ true
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

{ #category : #testing }
LcsBaseDomainObject >> isSupportDomainObject [
	^ false
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

{ #category : #'slot access' }
LcsBaseDomainObject >> virtualSlotVarNamed: aSlotName [
	"Return the value of the instance variable in me with that name"
	^ (self slotDefinitionNamed: aSlotName) currentSlotVarIn: self
]
