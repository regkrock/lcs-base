Class {
	#name : 'LcsGlobalCollectionSlotBuilder',
	#superclass : 'LcsAccessorSlotBuilder',
	#instVars : [
		'slotClass',
		'targetModule',
		'targetModuleName',
		'collectionClass',
		'slotTypeClassName'
	],
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'defaults' }
LcsGlobalCollectionSlotBuilder class >> slotClass [
	^ LcsGlobalCollectionSlot
]

{ #category : 'command' }
LcsGlobalCollectionSlotBuilder >> _populateSlotModel [
	super _populateSlotModel.
	self globalCollectionHome initializeSlotNamed: self slotName 
]

{ #category : 'gt views' }
LcsGlobalCollectionSlotBuilder >> addAssociationsToUmlModel: aUmlModel [
	super addAssociationsToUmlModel: aUmlModel.
	aUmlModel
		addAssociation: self slotName
			from: self parentClassName
			to: self collectionClassName;
		addAssociation: 'parent'
			from: self collectionClassName
			to: self parentClassName.
]

{ #category : 'gt views' }
LcsGlobalCollectionSlotBuilder >> addClassesToUmlModel: aUmlModel [
	super addClassesToUmlModel: aUmlModel.
	aUmlModel 
		addClassNamed: self targetClassName;
		addClassNamed: self parentClassName;
		addClassNamed: self collectionClassName
]

{ #category : 'gt views' }
LcsGlobalCollectionSlotBuilder >> addCollectionMemberType: aClass [
	self collectionMemberTypes add: aClass
]

{ #category : 'magritte' }
LcsGlobalCollectionSlotBuilder >> allowNilDescription [
	^ super allowNilDescription
		beReadOnly;
		yourself
]

{ #category : 'accessing' }
LcsGlobalCollectionSlotBuilder >> collectionClass [
	^ collectionClass
]

{ #category : 'accessing' }
LcsGlobalCollectionSlotBuilder >> collectionClass: anObject [
	collectionClass := anObject
]

{ #category : 'gt views' }
LcsGlobalCollectionSlotBuilder >> collectionClassName [
	^ self slotTypes first asString
]

{ #category : 'accessing' }
LcsGlobalCollectionSlotBuilder >> collectionMemberTypes [
	^ self properties at: 'collectionMemberTypes' ifAbsent: [ OrderedCollection new ]
]

{ #category : 'accessing' }
LcsGlobalCollectionSlotBuilder >> collectionMemberTypes: anObject [
	self properties at: 'collectionMemberTypes' put: anObject
]

{ #category : 'magritte' }
LcsGlobalCollectionSlotBuilder >> collectionMemberTypesDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Collection Member Types';
		priority: 32;
		accessor: (LcsMAPluggableAccessor 
						accessors: #(#collectionMemberTypes)
						read: [ :classes | classes collect: [ :each | each name] ] 
						write: [ :aModel :setter :collection | 
							aModel perform: setter with: (collection collect: [ :each | each asClass ] ) ]);
		classes: { String};
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocListStencil: (self
				taggerStencilWithCompletion: GtClassesCompletionStrategy new
				andContextMenuBlock: nil);
		blocShortcuts: [ {BlShortcutWithAction new
					name: 'Browse class';
					description: 'Browses the class indicated by the editor';
					combination: BlKeyCombination primaryB;
					action: [ :anEvent | 
						anEvent target phlow
							spawnTool: (GtClassCoderTool forClass: anEvent target text asString asClass) ].
				BlShortcutWithAction new
					name: 'Inspect class';
					description: 'Inspects the class indicated by the editor';
					combination: BlKeyCombination primaryG;
					action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass ].
				BlShortcutWithAction new
					name: 'Browse class references';
					description: 'Browses references to the class indicated by the editor';
					combination: BlKeyCombination primaryN;
					action: [ :anEvent | 
						anEvent target phlow
							spawnObject: anEvent target text asString asClass gtReferences ]} ];
		addCondition: [ :aValue | aValue asSet size = aValue size ]
			labelled: 'Duplicate classes are not allowed';
		addCondition: [ :aValue | 
				aValue
					allSatisfy: [ :eachClassName | 
						LcsBuilderLogger log: eachClassName isClass asString , ' - ' , eachClassName asString.
						eachClassName isClass or: [(Smalltalk classOrTraitNamed: eachClassName asString trim) isNotNil ] ] ]
			labelled: 'Unknown Class(s)';
		addCondition: [ :aValue | 
				| givenTraitsOrNils |
				givenTraitsOrNils := self classesOrNilsFor: aValue.
				givenTraitsOrNils allSatisfy: [ :each | each isNil or: [ each isClass ] ] ]
			labelled: 'Only classes are allowed';
		beRequired
]

{ #category : 'command' }
LcsGlobalCollectionSlotBuilder >> globalCollectionHome [
	^ self module
]

{ #category : 'initialize' }
LcsGlobalCollectionSlotBuilder >> initialize [
	super initialize.
	self collectionMemberTypes: OrderedCollection new.
	self collectionClass: LcsSmalltalkConfiguration identitySetClass
]

{ #category : 'initialize' }
LcsGlobalCollectionSlotBuilder >> initializeModel [
	(self targetClass slotDefinitionNamed: self slotName)
		initializeSlotValueIn: (self currentSystem moduleNamed: self targetModuleName)
]

{ #category : 'command' }
LcsGlobalCollectionSlotBuilder >> module [
	^ self currentSystem moduleNamed: self targetClass defaultModuleName
]

{ #category : 'gt views' }
LcsGlobalCollectionSlotBuilder >> parentClassName [
	^ self targetModuleClass name asString
]

{ #category : 'accessing' }
LcsGlobalCollectionSlotBuilder >> slotClass [
	^ slotClass 
]

{ #category : 'accessing' }
LcsGlobalCollectionSlotBuilder >> slotClass: anObject [
	slotClass := anObject
]

{ #category : 'accessing' }
LcsGlobalCollectionSlotBuilder >> slotTypeClass [
	^ [ self slotTypeClassName asString asClass ] on: NotFound do: [ :s | s return: nil ]
]

{ #category : 'accessing' }
LcsGlobalCollectionSlotBuilder >> slotTypeClassName [
	^ slotTypeClassName
]

{ #category : 'accessing' }
LcsGlobalCollectionSlotBuilder >> slotTypeClassName: aName [
	slotTypeClassName := aName
]

{ #category : 'accessing' }
LcsGlobalCollectionSlotBuilder >> targetModule [
	^ targetModule
	"^ self currentSystem moduleNamed: (self targetModuleName ifNil: [ self targetModuleClass defaultModuleName ])"
]

{ #category : 'accessing' }
LcsGlobalCollectionSlotBuilder >> targetModuleName [
	^ targetModuleName
]

{ #category : 'accessing' }
LcsGlobalCollectionSlotBuilder >> targetModuleName: anObject [
	targetModuleName := anObject
]

{ #category : 'gt views' }
LcsGlobalCollectionSlotBuilder >> umlModel [
	^ super umlModel
		positions: {(419.4818950229221@572.4021606445313). (412.3888888888889@645.0). (662.712894015842@576.0). (486.81529752443134@602.0). (486.81529752443134@602.0). (486.81529752443134@602.0). (553.0038905673557@567.3765194971581). (553.0038905673557@567.3765194971581). (553.0038905673557@567.3765194971581). (553.0038905673557@588.363342093737). (553.0038905673557@588.363342093737). (553.0038905673557@588.363342093737)};
		yourself
]

{ #category : 'command' }
LcsGlobalCollectionSlotBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass removeDomainSlotNamedFromSlotModel: self slotName].
]

{ #category : 'command' }
LcsGlobalCollectionSlotBuilder >> verifyUninstall [
	super verifyUninstall.
	self targetClass ifNotNil: [ self targetClass verifyRemovedDomainSlotNamed: self slotName ]
]
