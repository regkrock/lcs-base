"
This application is composed of a System and zero to many mdoules. This is the super class of all system and module classes.
"
Class {
	#name : #LcsBaseModule,
	#superclass : #LcsDomainObject,
	#instVars : [
		'modules',
		'domainCollections',
		'configuration'
	],
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #modules }
LcsBaseModule class >> allOwnedModuleCandidates [
	^ self allSubclasses select: [ :eachModuleClass | 
		eachModuleClass class pragmas anySatisfy: [ :eachPragma | 
			eachPragma selector = 'owningModule:'] ]
]

{ #category : #'system model' }
LcsBaseModule class >> allSubmoduleClasses [
	^ LcsAllSubmodulesVisitor allSubmodulesFor: self
]

{ #category : #'gt views' }
LcsBaseModule class >> baseWithNonLxxSubclasses [
	| classes |
	classes := (LcsBaseModule withAllSuperclasses , LcsBaseModule withAllSubclasses)
		 removeDuplicates;
		 yourself.
	classes remove: Object.
	#ProtoObject asClass ifNotNil: [ :proto | classes remove: proto ].
	(classes select: [ :each | (each name copyFrom: 1 to: 3) = 'Lxx' ]) do: [ :eachClass |
		classes remove: eachClass ].
	^classes
]

{ #category : #'slot definitions' }
LcsBaseModule class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: self moduleConfigurationClass
]

{ #category : #'slot definitions' }
LcsBaseModule class >> domainCollectionsSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'domainCollections';
		addSlotType: LcsGlobalCollections;
		addCollectionMemberType: LcsDomainCollection;
		yourself
]

{ #category : #modules }
LcsBaseModule class >> hasOwningModulePragmaFor: aPragma ownedBy: aModuleClass [
	| moduleName |
	(aPragma selector = 'owningModule:') ifFalse: [ ^ false ].
	moduleName := aPragma arguments at: 1.	
	^ moduleName = aModuleClass name asString 
]

{ #category : #'system model' }
LcsBaseModule class >> immediateSubmoduleClasses [
	^ LcsAllSubmodulesVisitor immediateSubmodulesFor: self
]

{ #category : #testing }
LcsBaseModule class >> isSubmoduleOf: aModuleClass [
	self class pragmas do:  [ :eachPragma | 
		(self hasOwningModulePragmaFor: eachPragma ownedBy: aModuleClass) ifTrue: [ ^true ] ].
	^ false
]

{ #category : #asking }
LcsBaseModule class >> moduleClassNamed: aString [
	^ self allSubclasses detect: [ :eachClass |
		eachClass moduleName = aString ]
		ifNone: []
]

{ #category : #'slot definitions' }
LcsBaseModule class >> moduleConfigurationClass [
	^ LcsBaseConfiguration
]

{ #category : #configuration }
LcsBaseModule class >> moduleName [
	^ self name
]

{ #category : #'slot definitions' }
LcsBaseModule class >> modulesSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'modules';
		addSlotType: LcsModules;
		addCollectionMemberType: LcsBaseModule;
		yourself
]

{ #category : #modules }
LcsBaseModule >> allSubmoduleClasses [
	^ self class allSubmoduleClasses
]

{ #category : #building }
LcsBaseModule >> buildModule: eachModuleClass [ 
	eachModuleClass hasSlotModel ifFalse: [
		eachModuleClass initializeSlotModel.].
	self modules buildModuleFor: eachModuleClass
]

{ #category : #building }
LcsBaseModule >> buildModules [
	self immediateSubmoduleClasses do: [ :eachModuleClass | self buildModule: eachModuleClass ]
]

{ #category : #accessing }
LcsBaseModule >> configuration [
	^ self slotVarNamed: 'configuration'
]

{ #category : #accessing }
LcsBaseModule >> configuration: anObject [
	self slotVarNamed: 'configuration' put: anObject
]

{ #category : #accessing }
LcsBaseModule >> domainCollections [
	^ self slotModel globalCollectionSlots collect: [ :each | self perform: each slotName asSymbol ]
]

{ #category : #accessing }
LcsBaseModule >> domainCollections: anObject [
	domainCollections := anObject
]

{ #category : #modules }
LcsBaseModule >> geographyModule [

	^ self moduleNamed: 'Geography Module'
]

{ #category : #accessing }
LcsBaseModule >> globalCollectionItems [
	^ self slotModel globalCollectionSlots
		collect: [ :eachSlotDefinition | 
			LcsGlobalCollectionItem
				newLabel: eachSlotDefinition slotName
				item: (self perform: eachSlotDefinition slotName asSymbol) ]
]

{ #category : #'gt views' }
LcsBaseModule >> gtApplicationModulesFor: aView [
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
LcsBaseModule >> gtGlobalCollectionsFor: aView [
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
		yourself
]

{ #category : #testing }
LcsBaseModule >> hasModules [
	^ self modules hasElements
]

{ #category : #testing }
LcsBaseModule >> hasNoModules [
	^ self modules hasNoElements
]

{ #category : #modules }
LcsBaseModule >> immediateSubmoduleClasses [
	^ self class immediateSubmoduleClasses
]

{ #category : #initialize }
LcsBaseModule >> initializeModel [
	super initializeModel.
	"self modules initializeModel"
]

{ #category : #modules }
LcsBaseModule >> installModule: aModuleClass [

	"self currentSystem globalCollections remove: aModuleClass ifAbsent: [ ]."
	aModuleClass initializeSlotModel.
	self buildModule: aModuleClass

]

{ #category : #modules }
LcsBaseModule >> legalEntitiesModule [

	^ self moduleNamed: 'Legal Entities Module'
]

{ #category : #configuration }
LcsBaseModule >> moduleName [
	^ self class moduleName
]

{ #category : #modules }
LcsBaseModule >> moduleNamed: aString [
	| foundModule |
	self moduleName = aString ifTrue: [ ^ self ].
	foundModule := self modules findModuleNamed: aString.
	foundModule
		ifNil: [ LcsModuleNotFoundError signal: 'Module not found: ' , aString asString ]
		ifNotNil: [ ^ foundModule ]
]

{ #category : #modules }
LcsBaseModule >> moduleViewChildren [
	^ self modules moduleViewChildren
]

{ #category : #accessing }
LcsBaseModule >> modules [
	^ self slotVarNamed: 'modules'
]

{ #category : #accessing }
LcsBaseModule >> modules: anObject [
	modules := anObject
]

{ #category : #modules }
LcsBaseModule >> modulesDo: aBlock [ 
	self modules do: aBlock
]

{ #category : #modules }
LcsBaseModule >> numberOfChildModules [
	^ self modules numberOfModules
]

{ #category : #accessing }
LcsBaseModule >> objectId [
	^ self hash
]

{ #category : #accessing }
LcsBaseModule >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' (';
		nextPutAll: self objectId asString;
		nextPutAll: ')'
]
