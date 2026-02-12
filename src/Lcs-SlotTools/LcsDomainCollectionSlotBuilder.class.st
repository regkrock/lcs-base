Class {
	#name : 'LcsDomainCollectionSlotBuilder',
	#superclass : 'LcsDomainObjectSlotBuilder',
	#instVars : [
		'slotClass',
		'targetModule',
		'targetModuleName',
		'collectionClass',
		'slotTypeClassName'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'defaults' }
LcsDomainCollectionSlotBuilder class >> slotClass [
	self subclassResponsibility
]

{ #category : 'command' }
LcsDomainCollectionSlotBuilder >> _populateSlotModel [
	super _populateSlotModel.

		"| aModule |
	aModule := self module.
	(aModule perform: self getterSelector)
		ifNil: [ aModule initializeSlotNamed: self slotName ]"
]

{ #category : 'gt views' }
LcsDomainCollectionSlotBuilder >> addAssociationsToUmlModel: aUmlModel [
	super addAssociationsToUmlModel: aUmlModel.
	aUmlModel
		addAssociation: self slotName
			from: self targetClassName
			to: self slotTypes first asString;
		addAssociation: 'parent'
			from: self slotTypes first asString
			to: self targetClassName
]

{ #category : 'gt views' }
LcsDomainCollectionSlotBuilder >> addClassesToUmlModel: aUmlModel [
	super addClassesToUmlModel: aUmlModel.
	self slotTypes isEmpty ifTrue: [ ^ self ].
	aUmlModel addClassNamed: (self slotTypes first isString ifTrue: [  self slotTypes first ] ifFalse: [ self slotTypes first name asString ]).
]

{ #category : 'gt views' }
LcsDomainCollectionSlotBuilder >> addCollectionMemberType: aClassName [
	self collectionMemberTypes add: aClassName

]

{ #category : 'code generation' }
LcsDomainCollectionSlotBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
	self slotTypes do: [ :each |
		aCodeStream addKeyword: 'addSlotType' argument: each ].
	self collectionClass notNil ifTrue: [
		aCodeStream
			addKeyword: 'collectionClass' argument: self collectionClass name].
	self collectionMemberTypes do: [ :eachClass |
		aCodeStream addKeyword: 'addCollectionMemberType' argument: (eachClass isString ifTrue: [ eachClass ] ifFalse: [ eachClass name ] )].
	self collectionClass isNil ifTrue: [
		aCodeStream addUnaryMessage: 'beIdentitySetCollection']

]

{ #category : 'accessing' }
LcsDomainCollectionSlotBuilder >> collectionClass [
	^ collectionClass
]

{ #category : 'accessing' }
LcsDomainCollectionSlotBuilder >> collectionClass: anObject [
	collectionClass := anObject
]

{ #category : 'accessing' }
LcsDomainCollectionSlotBuilder >> collectionMemberTypes [
	^ self properties at: 'collectionMemberTypes' ifAbsent: [ OrderedCollection new ]
]

{ #category : 'accessing' }
LcsDomainCollectionSlotBuilder >> collectionMemberTypes: anObject [
	self properties at: 'collectionMemberTypes' put: anObject
]

{ #category : 'margritte' }
LcsDomainCollectionSlotBuilder >> collectionMemberTypesDescription [
	"<magritteDescription>"
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

{ #category : 'job steps' }
LcsDomainCollectionSlotBuilder >> domainClassBuilder: aClassName [ 
	^ LcsDomainClassBuilder new
		newClassName: aClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : 'job steps' }
LcsDomainCollectionSlotBuilder >> domainCollectionClassBuilder: aClassName [ 
	^ LcsDomainCollectionClassBuilder new
		newClassName: aClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : 'initialize' }
LcsDomainCollectionSlotBuilder >> initialize [
	super initialize.
	self collectionMemberTypes:	OrderedCollection new.
	self collectionClass: LcsSmalltalkConfiguration identitySetClass
]

{ #category : 'initialize' }
LcsDomainCollectionSlotBuilder >> initializeModel [
	(self targetClass slotDefinitionNamed: self slotName)
		initializeSlotValueIn: (self currentSystem moduleNamed: self targetModuleName)
]

{ #category : 'command' }
LcsDomainCollectionSlotBuilder >> module [
	^ self currentSystem moduleNamed: self targetClass defaultModuleName
]

{ #category : 'accessing' }
LcsDomainCollectionSlotBuilder >> slotClass [
	^ slotClass 
]

{ #category : 'accessing' }
LcsDomainCollectionSlotBuilder >> slotClass: anObject [
	slotClass := anObject
]

{ #category : 'accessing' }
LcsDomainCollectionSlotBuilder >> slotTypeClass [
	self deprecated: 'Use slotTypes'.
	^ self slotTypeClassName asClass
]

{ #category : 'accessing' }
LcsDomainCollectionSlotBuilder >> slotTypeClassName [
	self deprecated: 'Use slotTypes'.
	^ slotTypeClassName ifNil: [ self slotClass name ]
]

{ #category : 'accessing' }
LcsDomainCollectionSlotBuilder >> targetModule [
	^ self currentSystem moduleNamed: (self targetModuleName ifNil: [ self targetModuleClass defaultModuleName ])
]

{ #category : 'accessing' }
LcsDomainCollectionSlotBuilder >> targetModuleName [
	^ targetModuleName
]

{ #category : 'accessing' }
LcsDomainCollectionSlotBuilder >> targetModuleName: anObject [
	targetModuleName := anObject
]

{ #category : 'gt views' }
LcsDomainCollectionSlotBuilder >> umlModel [
	^ super umlModel
		positions: {(893.654665629069@613.1956787109375). (637.4816652933756@543.0). (643.9736658732096@613.5978393554688). (647.4766680399576@472.40216064453125). (421.66666666666663@620.1956787109375). (864.6096674601237@734.7935180664063). (705.8966662089031@502.00000000000006). (705.8966662089031@572.5978393554688). (503.21408741455525@502.0). (930.8563544660587@642.7935180664063). (930.8563544660587@642.7935180664063). (930.8563544660587@642.7935180664063). (930.8563544660587@642.7935180664063). (930.8563544660587@642.7935180664063). (930.8563544660587@642.7935180664063). (767.8196665445962@628.059948546854). (767.8196665445962@628.059948546854). (767.8196665445962@628.059948546854). (767.8196665445962@628.059948546854). (767.8196665445962@628.059948546854). (767.8196665445962@628.059948546854). (539.654665629069@630.2106698135083). (539.654665629069@630.2106698135083). (539.654665629069@630.2106698135083). (539.654665629069@630.2106698135083). (539.654665629069@630.2106698135083). (539.654665629069@630.2106698135083). (767.8196665445962@603.0056195696627). (767.8196665445962@603.0056195696627). (767.8196665445962@603.0056195696627). (767.8196665445962@603.0056195696627). (767.8196665445962@603.0056195696627). (767.8196665445962@603.0056195696627). (539.654665629069@610.8747782809642). (539.654665629069@610.8747782809642). (539.654665629069@610.8747782809642). (539.654665629069@610.8747782809642). (539.654665629069@610.8747782809642). (539.654665629069@610.8747782809642)};
		yourself
]

{ #category : 'command' }
LcsDomainCollectionSlotBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass removeDomainSlotNamed: self slotName ]
]

{ #category : 'command' }
LcsDomainCollectionSlotBuilder >> verifyUninstall [
	super verifyUninstall.
	self targetClass ifNotNil: [ self targetClass verifyRemovedDomainSlotNamed: self slotName ]
]
