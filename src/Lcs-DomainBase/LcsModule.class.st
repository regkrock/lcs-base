"
This application is composed of a System and zero to many mdoules. This is the super class of all system and module classes.
"
Class {
	#name : #LcsModule,
	#superclass : #LcsDomainObject,
	#instVars : [
		'modules',
		'domainCollections',
		'configuration',
		'moduleName'
	],
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #modules }
LcsModule class >> allOwnedModuleCandidates [
	^ self allSubclasses select: [ :eachModuleClass | 
		eachModuleClass class pragmas anySatisfy: [ :eachPragma | 
			eachPragma selector = 'owningModule:'] ]
]

{ #category : #'system model' }
LcsModule class >> allSubmoduleClasses [
	^ LcsAllSubmodulesVisitor allSubmodulesFor: self
]

{ #category : #'gt views' }
LcsModule class >> baseWithNonLxxSubclasses [
	| classes |
	classes := (LcsModule withAllSuperclasses , LcsModule withAllSubclasses)
		 removeDuplicates;
		 yourself.
	classes remove: Object.
	#ProtoObject asClass ifNotNil: [ :proto | classes remove: proto ].
	(classes select: [ :each | (each name copyFrom: 1 to: 3) = 'Lxx' ]) do: [ :eachClass |
		classes remove: eachClass ].
	^classes
]

{ #category : #'slot definitions' }
LcsModule class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: self moduleConfigurationClass
]

{ #category : #configuration }
LcsModule class >> defaultModuleName [
	^ self name
]

{ #category : #'slot definitions' }
LcsModule class >> domainCollectionsSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'domainCollections';
		addSlotType: LcsGlobalCollections;
		addCollectionMemberType: LcsDomainCollection;
		yourself
]

{ #category : #modules }
LcsModule class >> hasOwningModulePragmaFor: aPragma ownedBy: aModuleClass [
	| moduleName |
	(aPragma selector = 'owningModule:') ifFalse: [ ^ false ].
	moduleName := aPragma arguments at: 1.	
	^ moduleName = aModuleClass name asString 
]

{ #category : #'system model' }
LcsModule class >> immediateSubmoduleClasses [
	^ LcsAllSubmodulesVisitor immediateSubmodulesFor: self
]

{ #category : #testing }
LcsModule class >> isSubmoduleOf: aModuleClass [
	self class pragmas do:  [ :eachPragma | 
		(self hasOwningModulePragmaFor: eachPragma ownedBy: aModuleClass) ifTrue: [ ^true ] ].
	^ false
]

{ #category : #asking }
LcsModule class >> moduleClassNamed: aString [
	^ self allSubclasses detect: [ :eachClass |
		eachClass defaultModuleName = aString ]
		ifNone: []
]

{ #category : #'slot definitions' }
LcsModule class >> moduleConfigurationClass [
	^ LcsBaseConfiguration
]

{ #category : #'slot definitions' }
LcsModule class >> moduleNameSlotDefinition [
	<slotDefinition>
	^ LcsModuleNameSlot new
]

{ #category : #'slot definitions' }
LcsModule class >> modulesSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'modules';
		addSlotType: LcsModules;
		addCollectionMemberType: LcsModule;
		yourself
]

{ #category : #modules }
LcsModule >> allSubmoduleClasses [
	^ self class allSubmoduleClasses
]

{ #category : #building }
LcsModule >> buildModule: eachModuleClass [ 
	eachModuleClass hasSlotModel ifFalse: [
		eachModuleClass initializeSlotModel.].
	self modules buildModuleFor: eachModuleClass
]

{ #category : #building }
LcsModule >> buildModules [
	self immediateSubmoduleClasses do: [ :eachModuleClass | self buildModule: eachModuleClass ]
]

{ #category : #accessing }
LcsModule >> configuration [
	^ self slotVarNamed: 'configuration'
]

{ #category : #accessing }
LcsModule >> configuration: anObject [
	self slotVarNamed: 'configuration' put: anObject
]

{ #category : #accessing }
LcsModule >> domainCollections [
	^ self slotModel globalCollectionSlots collect: [ :each | self perform: each slotName asSymbol ]
]

{ #category : #accessing }
LcsModule >> domainCollections: anObject [
	domainCollections := anObject
]

{ #category : #modules }
LcsModule >> geographyModule [

	^ self moduleNamed: 'Geography Module'
]

{ #category : #accessing }
LcsModule >> globalCollectionItems [
	^ self slotModel globalCollectionSlots
		collect: [ :eachSlotDefinition | 
			LcsGlobalCollectionItem
				newLabel: eachSlotDefinition slotName
				item: (self perform: eachSlotDefinition slotName asSymbol) ]
]

{ #category : #'gt views' }
LcsModule >> gtApplicationModulesFor: aView [
	<gtView>
	(self modules isNil or: [ self modules hasNoElements ])
		ifTrue: [ 
			^ aView list
				title: 'Modules';
				priority: 1;
				items: #('Has no submodules');
				yourself ].
	^ aView forward
		title: 'Modules';
		priority: 1;
		object: [ self modules ];
		view: #gtApplicationModulesFor:;
		yourself
]

{ #category : #'gt views' }
LcsModule >> gtGlobalCollectionsFor: aView [
	<gtView>
	 self domainCollections isEmpty ifTrue: [ ^ aView empty]. 
	^ aView columnedTree
		title: 'Global Collections';
		priority: 9;
		items: [ self globalCollectionItems ];
		column: 'Slot'
			text: [ :item | item  label asString ]
			width: 100;
		column: 'Size'
			text: [ :item | item item 
								ifNil: [ '' ] 
								ifNotNil: [ item item collectionSize printString ] ]
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

{ #category : #testing }
LcsModule >> hasModules [
	^ self modules hasElements
]

{ #category : #testing }
LcsModule >> hasNoModules [
	^ self modules hasNoElements
]

{ #category : #modules }
LcsModule >> immediateSubmoduleClasses [
	^ self class immediateSubmoduleClasses
]

{ #category : #initialize }
LcsModule >> initializeModel [
	super initializeModel.
	"self modules initializeModel"
]

{ #category : #modules }
LcsModule >> installModule: aModuleClass [

	"self currentSystem globalCollections remove: aModuleClass ifAbsent: [ ]."
	aModuleClass initializeSlotModel.
	self buildModule: aModuleClass

]

{ #category : #modules }
LcsModule >> legalEntitiesModule [

	^ self moduleNamed: 'Legal Entities Module'
]

{ #category : #initialize }
LcsModule >> loadData [
	self loadSingletonCodeCollections
]

{ #category : #initialize }
LcsModule >> loadSingletonCodeCollections [
	"self slotModel loadSingletonCodeCollections.
	self modules do: [ :eachModule | eachModule loadSingletonCodeCollections ]"
]

{ #category : #accessing }
LcsModule >> moduleName [
	^ self slotVarNamed: 'moduleName'
]

{ #category : #accessing }
LcsModule >> moduleName: anObject [
	self slotVarNamed: 'moduleName' put: anObject
]

{ #category : #modules }
LcsModule >> moduleNamed: aString [
	| foundModule |
	self moduleName = aString ifTrue: [ ^ self ].
	foundModule := self modules findModuleNamed: aString.
	foundModule
		ifNil: [ LcsModuleNotFoundError signal: 'Module not found: ' , aString asString ]
		ifNotNil: [ ^ foundModule ]
]

{ #category : #modules }
LcsModule >> moduleViewChildren [
	^ self modules moduleViewChildren
]

{ #category : #accessing }
LcsModule >> modules [
	^ self slotVarNamed: 'modules'
]

{ #category : #accessing }
LcsModule >> modules: anObject [
	modules := anObject
]

{ #category : #modules }
LcsModule >> modulesDo: aBlock [ 
	self modules do: aBlock
]

{ #category : #modules }
LcsModule >> numberOfChildModules [
	^ self modules numberOfModules
]

{ #category : #accessing }
LcsModule >> objectId [
	^ self hash
]

{ #category : #accessing }
LcsModule >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' (';
		nextPutAll: self objectId asString;
		nextPutAll: ')'
]
