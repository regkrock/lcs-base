"
This application is composed of a System and zero to many mdoules. This is the super class of all system and module classes.
"
Class {
	#name : 'LcsModule',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'modules',
		'domainCollections',
		'configuration',
		'moduleName'
	],
	#category : 'Lcs-DomainBase-Core',
	#package : 'Lcs-DomainBase',
	#tag : 'Core'
}

{ #category : 'slot model' }
LcsModule class >> addUniqueSubmodulePragmasOf: aClass in: submodulePragamsWithDuplicates  to: submodulePragams [
	submodulePragamsWithDuplicates
		do: [ :each | 
			submodulePragams
				detect: [ :e | (e argumentNamed: #owningModule) = aClass name asString and: [ e methodClass = each methodClass ] ]
				ifNone: [ submodulePragams add: each ] ]
]

{ #category : 'modules' }
LcsModule class >> allOwnedModuleCandidates [
	^ self allSubclasses select: [ :eachModuleClass | 
		eachModuleClass class pragmas anySatisfy: [ :eachPragma | 
			eachPragma selector = 'owningModule:priority:'] ]
]

{ #category : 'system model' }
LcsModule class >> allSubmoduleClasses [
	^ LcsAllSubmodulesVisitor allSubmodulesFor: self
]

{ #category : 'gt views' }
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

{ #category : 'slot definitions' }
LcsModule class >> configurationSlotDefinition [
	<accessorSlotDefinition>
	^ self configurationSlotDefinitionOn: self moduleConfigurationClass
]

{ #category : 'slot definitions - support' }
LcsModule class >> configurationSlotDefinitionOn: aClass [
	^ LcsModuleConfigurationSlot newOn: aClass
]

{ #category : 'configuration' }
LcsModule class >> defaultModuleName [
	self subclassResponsibility
]

{ #category : 'slot model - install' }
LcsModule class >> domainClassesInPackage [
	| domainClasses |
	domainClasses := self package classes reject: [ :each | each isMeta ].
	self systemModelDependentPackages do: [ :eachPackage |
		domainClasses addAll: (eachPackage classes reject: [ :each | each isMeta ]) ].
	^ domainClasses
]

{ #category : 'slot definitions' }
LcsModule class >> domainCollectionsSlotDefinition [
	<accessorSlotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'domainCollections';
		addSlotType: LcsGlobalCollections;
		addCollectionMemberType: LcsDomainCollection;
		priority: 3;
		yourself
]

{ #category : 'gt views' }
LcsModule class >> gtSlotDefinitionMethodFor: aView [
	<gtView>
	<gtClassView>
	^ aView explicit
		title: 'Slot Defn Methods';
		tooltip: 'Methods that define Slot Defintions';
		priority: 19;
		stencil: [ (self class gtMethodsInClass includeSuperclass: true)
				& ( #accessorSlotDefinition gtPragmas | #collectionItemSlotDefinition gtPragmas) ];
		actionUpdateButton
]

{ #category : 'gt views' }
LcsModule class >> gtSubmodulesFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedTree
		title: 'Submodules';
		tooltip: 'Submodules of this module';
		priority: 22;
		items: [ self immediateSubmodulePragmas ];
		children: [ :each | each methodClass soleInstance immediateSubmodulePragmas ];
		column: 'Class' text: [ :each | each methodClass soleInstance ];
		column: 'Priority' text: [ :each | each argumentNamed: #priority ];
		send: [ :eachPragma | eachPragma methodClass soleInstance ];
		actionUpdateButton
]

{ #category : 'modules' }
LcsModule class >> hasOwningModulePragmaFor: aPragma ownedBy: aModuleClass [
	| moduleName |
	(aPragma selector = 'owningModule:priority:') ifFalse: [ ^ false ].
	moduleName := aPragma arguments at: 1.	
	^ moduleName = aModuleClass name asString 
]

{ #category : 'system model' }
LcsModule class >> immediateSubmoduleClasses [
	^ self immediateSubmoduleClassesOf: self
]

{ #category : 'slot model' }
LcsModule class >> immediateSubmoduleClassesOf: aClass [
	| immediateSubmodulePragmas submoduleClasses |
	immediateSubmodulePragmas := self immediateSubmodulePragmasOf: aClass.
	submoduleClasses := immediateSubmodulePragmas collect: [ :eachPragma | eachPragma methodClass soleInstance ].
	^ submoduleClasses
		reject: [ :each | each isObsolete or: [ (each name findString: 'Obsolete') > 0 ] ]
]

{ #category : 'system model' }
LcsModule class >> immediateSubmodulePragmas [
	^ self immediateSubmodulePragmasOf: self
]

{ #category : 'slot model' }
LcsModule class >> immediateSubmodulePragmasOf: aClass [
	| submodulePragams |
	submodulePragams := OrderedCollection new.
	"When the method is saved an additional entry is add to the Pragma cache. Hence the duplicates"
	self
		addUniqueSubmodulePragmasOf: aClass
		in: (self immediateSubmodulePragmasWithDuplicatesOf: aClass)
		to: submodulePragams.
	^ submodulePragams
		asSortedCollection: [ :a :b | (a argumentNamed: #priority) <= (b argumentNamed: #priority) ]
]

{ #category : 'slot model' }
LcsModule class >> immediateSubmodulePragmasWithDuplicatesOf: aClass [
	^ (Pragma pragmaCache at: 'owningModule:priority:')
		select: [ :each | (each argumentNamed: #owningModule) = aClass name asString ]
]

{ #category : 'testing' }
LcsModule class >> isSubmoduleOf: aModuleClass [
	self class pragmas do:  [ :eachPragma | 
		(self hasOwningModulePragmaFor: eachPragma ownedBy: aModuleClass) ifTrue: [ ^true ] ].
	^ false
]

{ #category : 'modules' }
LcsModule class >> loadPriorityInOwningModule: aModuleClass [
	^ (self owningModulePriortyModulePragmas
		detect: [ :eachPragma | (eachPragma argumentNamed: #'owningModule:') = aModuleClass name asString ]
		ifNone: [ ^ 0 ]) argumentNamed: #'priority:'
]

{ #category : 'modules' }
LcsModule class >> moduleClassNamed: aString [
	^ self allSubclasses detect: [ :eachClass |
		eachClass defaultModuleName = aString ]
		ifNone: []
]

{ #category : 'configuration' }
LcsModule class >> moduleConfigurationClass [
	^ LcsBaseConfiguration
]

{ #category : 'slot definitions' }
LcsModule class >> moduleNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsModuleNameSlot new
		priority: 1;
		yourself
]

{ #category : 'slot definitions' }
LcsModule class >> modulesSlotDefinition [
	<accessorSlotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'modules';
		addSlotType: LcsModules;
		addCollectionMemberType: LcsModule;
		priority: 2;
		yourself
]

{ #category : 'modules' }
LcsModule class >> owningModulePriortyModulePragmas [
	^ self class pragmas select: [ :each | each selector = #owningModule:priority: ]
]

{ #category : 'slot model - install' }
LcsModule class >> systemModelDependentPackages [
	^ OrderedCollection new
]

{ #category : 'modules' }
LcsModule >> _moduleNamed: aString [
	self moduleName = aString ifTrue: [ ^ self ].
	self modules ifNil: [ ^ nil ].
	^ self modules findModuleNamed: aString
]

{ #category : 'modules' }
LcsModule >> allSubmoduleClasses [
	^ self class allSubmoduleClasses
]

{ #category : 'building' }
LcsModule >> buildModule: eachModuleClass [ 
	eachModuleClass hasSlotModel ifFalse: [
		eachModuleClass initializeSlotModel.].
	self modules buildModuleFor: eachModuleClass
]

{ #category : 'building' }
LcsModule >> buildModules [
	LcsLogger indent.
	LcsLogger log: 'Building modules: '.
	self immediateSubmoduleClasses do: [ :eachModuleClass | self buildModule: eachModuleClass ].
	LcsLogger outdent.
]

{ #category : 'accessing' }
LcsModule >> configuration [
	^ self slotVarNamed: 'configuration'
]

{ #category : 'accessing' }
LcsModule >> configuration: anObject [
	self slotVarNamed: 'configuration' put: anObject
]

{ #category : 'accessing' }
LcsModule >> domainCollections [
	^ self slotModel globalCollectionSlots collect: [ :each | self perform: each slotName asSymbol ]
]

{ #category : 'accessing' }
LcsModule >> domainCollections: anObject [
	domainCollections := anObject
]

{ #category : 'querying' }
LcsModule >> globalCollectionItems [
	self slotModel ifNil: [ ^ OrderedCollection new ].
	^ self slotModel globalCollectionSlots
		collect: [ :eachSlotDefinition | 
			LcsGlobalCollectionViewItem
				newLabel: eachSlotDefinition slotName
				item: (self perform: eachSlotDefinition slotName asSymbol) ]
]

{ #category : 'gt views' }
LcsModule >> gtApplicationModulesFor: aView [
	<gtView>
	self slotModel ifNil: [
		^ aView text
			title: 'Modules';
			priority: 1;
			text: [ 'System Is Not Active' ];
			actionUpdateButton].
	(self modules isNil or: [ self modules hasNoElements ])
		ifTrue: [ 
			^ aView list
				title: 'Modules';
				priority: 1;
				items: #('Has no submodules');
				actionUpdateButton;
				yourself ].
	^ aView forward
		title: 'Modules';
		priority: 1;
		object: [ self modules ];
		view: #gtApplicationModulesFor:;
		actionUpdateButton;
		yourself
]

{ #category : 'gt views' }
LcsModule >> gtGlobalCollectionsFor: aView [
	<gtView>
	 "self domainCollections isEmpty ifTrue: [ ^ aView empty]. "
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
		column: 'Type'
			text: [ :item | item collectionType ]
			width: 60;
		actionDropdownButtonIcon: BrGlamorousVectorIcons spawn 
			tooltip: 'Add Global Collection Slot'
			content: [ :aDropdown |
				BlElement new
					constraintsDo: [ :c | 
						c horizontal fitContent.
						c vertical fitContent ];
					layout: BlLinearLayout vertical;
					padding: (BlInsets all: 10);
					addChild: (
						BrButton new
							aptitude: BrGlamorousButtonWithLabelAptitude;
							label: 'Add Global Collection';
							action: [ aDropdown phlow spawnObject: (LcsGlobalCollectionPatternForm newOn: self) ]);
					addChild: (
						BrButton new
							aptitude: BrGlamorousButtonWithLabelAptitude;
							label: 'Add Global Collection With Domain Having A Local Collection';
							action: [ aDropdown phlow spawnObject: (LcsGlobalCollectionWithDomainHavingALocalCollectionPatternForm newOn: self) ]);
					addChild: (
						BrButton new
							aptitude: BrGlamorousButtonWithLabelAptitude;
							label: 'Add Value Global Collection';
							action: [ aDropdown phlow spawnObject: (LcsValueCollectionPatternForm newOn: self) ]);
					addChild: (
						BrButton new
							aptitude: BrGlamorousButtonWithLabelAptitude;
							label: 'Add Singleton Value Global Collection';
							action: [ aDropdown phlow spawnObject: (LcsSingletonValueCollectionPatternForm newOn: self) ]).
 						];
		send: #item;
		actionUpdateButton;
		yourself
]

{ #category : 'testing' }
LcsModule >> hasModules [
	^ self modules hasElements
]

{ #category : 'testing' }
LcsModule >> hasNoModules [
	^ self modules hasNoElements
]

{ #category : 'modules' }
LcsModule >> immediateSubmoduleClasses [
	^ self class immediateSubmoduleClasses
]

{ #category : 'modules' }
LcsModule >> installModule: aModuleClass [

	"self currentSystem globalCollections remove: aModuleClass ifAbsent: [ ]."
	aModuleClass initializeSlotModel.
	self buildModule: aModuleClass

]

{ #category : 'initialize' }
LcsModule >> loadData [
	self loadSingletonCodeCollections
]

{ #category : 'building' }
LcsModule >> loadPriority [
	self owningModule ifNil: [ ^ 0 ].
	^ self class loadPriorityInOwningModule: self owningModule class
]

{ #category : 'initialize' }
LcsModule >> loadSingletonCodeCollections [
	"self slotModel loadSingletonCodeCollections.
	self modules do: [ :eachModule | eachModule loadSingletonCodeCollections ]"
]

{ #category : 'accessing' }
LcsModule >> moduleName [
	^ self _slotVarNamed: 'moduleName'
]

{ #category : 'accessing' }
LcsModule >> moduleName: anObject [
	self slotVarNamed: 'moduleName' put: anObject
]

{ #category : 'modules' }
LcsModule >> moduleNamed: aString [
	^ (self _moduleNamed: aString)
		ifNil: [ LcsModuleNotFoundError signal: 'Module not found: ' , aString printString , ' in current system: ' , self currentSystem printString ]
		ifNotNil: [ :foundModule | foundModule ]
]

{ #category : 'modules' }
LcsModule >> moduleViewChildren [
	self modules ifNil: [ ^ #() ].
	^ self modules moduleViewChildren 
]

{ #category : 'accessing' }
LcsModule >> modules [
	^ self _slotVarNamed: 'modules'
]

{ #category : 'accessing' }
LcsModule >> modules: anObject [
	modules := anObject
]

{ #category : 'modules' }
LcsModule >> modulesDo: aBlock [ 
	self modules do: aBlock
]

{ #category : 'modules' }
LcsModule >> numberOfChildModules [
	^ self modules numberOfModules
]

{ #category : 'accessing' }
LcsModule >> objectId [
	^ self hash
]

{ #category : 'modules' }
LcsModule >> owningModule [
	^ self parent ifNotNil: [ :each | each parent ]
]

{ #category : 'asking' }
LcsModule >> parentModuleClassName [
	^ self parent parent class name asString
]

{ #category : 'accessing' }
LcsModule >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' (';
		nextPutAll: self objectId asString;
		nextPutAll: ')'
]
