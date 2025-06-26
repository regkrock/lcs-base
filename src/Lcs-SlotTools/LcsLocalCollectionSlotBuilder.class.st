Class {
	#name : #LcsLocalCollectionSlotBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#instVars : [
		'slotClass',
		'collectionElementTypes',
		'targetModule',
		'targetModuleName',
		'collectionClass',
		'slotTypeClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #defaults }
LcsLocalCollectionSlotBuilder class >> slotDefinitionClass [
	^ LcsLocalCollectionSlot
]

{ #category : #'gt views' }
LcsLocalCollectionSlotBuilder >> addAssociationsToUmlModel: aClassesModel [
	super addAssociationsToUmlModel: aClassesModel.
	(aClassesModel classModelForClassname: self targetModuleClass name asString)
		addAssociation: self slotName toModelNamed: self slotTypes first.
	(aClassesModel classModelForClassname: self slotTypes first)
		addAssociation: 'parent' toModelNamed: self targetClassName
]

{ #category : #'gt views' }
LcsLocalCollectionSlotBuilder >> addCollectionElementType: aClassName [
	self collectionElementTypes add: aClassName

]

{ #category : #'code generation' }
LcsLocalCollectionSlotBuilder >> addExtraPropertiesTo: aSlotDefinitionMethodBuilder [
	super addExtraPropertiesTo: aSlotDefinitionMethodBuilder.
	self collectionElementTypes do: [ :each |
		aSlotDefinitionMethodBuilder 
			addProperty: 'addCollectionMemberType' 
			value: each ]
]

{ #category : #'code generation' }
LcsLocalCollectionSlotBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
	self slotTypes do: [ :each |
		aCodeStream addKeyword: 'addSlotType' argument: each ].
	self collectionClass notNil ifTrue: [
		aCodeStream
			addKeyword: 'collectionClass' argument: self collectionClass name].
	self collectionElementTypes do: [ :eachClass |
		aCodeStream addKeyword: 'addCollectionMemberType' argument: (eachClass isString ifTrue: [ eachClass ] ifFalse: [ eachClass name ] )].
	self collectionClass isNil ifTrue: [
		aCodeStream addUnaryMessage: 'beIdentitySetCollection']

]

{ #category : #'job steps' }
LcsLocalCollectionSlotBuilder >> buildJobSteps [
	self slotTypes do: [ :eachClassName | 
		(self classFor: eachClassName) ifNil: [ 
			(self addJobStep: (self domainCollectionClassBuilder: eachClassName)) ] ].
	self collectionElementTypes do: [ :eachClassName | 
		(self classFor: eachClassName) ifNil: [ 
			(self addJobStep: (self domainClassBuilder: eachClassName)).
			(self addJobStep: (self localCollectionReferenceSlotBuilder: eachClassName)) ] ].
	super buildJobSteps
]

{ #category : #accessing }
LcsLocalCollectionSlotBuilder >> collectionClass [
	^ collectionClass
]

{ #category : #accessing }
LcsLocalCollectionSlotBuilder >> collectionClass: anObject [
	collectionClass := anObject
]

{ #category : #accessing }
LcsLocalCollectionSlotBuilder >> collectionElementTypes [
	^ collectionElementTypes
]

{ #category : #accessing }
LcsLocalCollectionSlotBuilder >> collectionElementTypes: anObject [
	collectionElementTypes := anObject
]

{ #category : #'job steps' }
LcsLocalCollectionSlotBuilder >> domainClassBuilder: aClassName [ 
	^ LcsDomainClassBuilder new
		newClassName: aClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #'job steps' }
LcsLocalCollectionSlotBuilder >> domainCollectionClassBuilder: aClassName [ 
	^ LcsDomainCollectionClassBuilder new
		newClassName: aClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #initialize }
LcsLocalCollectionSlotBuilder >> initialize [
	super initialize.
	self collectionElementTypes:	OrderedCollection new.
	self collectionClass: LcsSmalltalkConfiguration identitySetClass
]

{ #category : #initialize }
LcsLocalCollectionSlotBuilder >> initializeModel [
	(self targetClass slotDefinitionNamed: self slotName)
		initializeSlotValueIn: (self currentSystem moduleNamed: self targetModuleName)
]

{ #category : #'job steps' }
LcsLocalCollectionSlotBuilder >> localCollectionReferenceSlotBuilder: aClassName [
	^ LcsLocalCollectionReferenceSlotBuilder new
		targetClassName: aClassName;
		collectionSlotName: self slotName;
		addSlotType: self slotTypes first;
		yourself
]

{ #category : #command }
LcsLocalCollectionSlotBuilder >> module [
	^ self currentSystem moduleNamed: self targetClass defaultModuleName
]

{ #category : #command }
LcsLocalCollectionSlotBuilder >> populateSlotModel [
	super populateSlotModel.

		"| aModule |
	aModule := self module.
	(aModule perform: self getterSelector)
		ifNil: [ aModule initializeSlotNamed: self slotName ]"
]

{ #category : #accessing }
LcsLocalCollectionSlotBuilder >> slotClass [
	^ slotClass 
]

{ #category : #accessing }
LcsLocalCollectionSlotBuilder >> slotClass: anObject [
	slotClass := anObject
]

{ #category : #accessing }
LcsLocalCollectionSlotBuilder >> slotTypeClass [
	self deprecated: 'Use slotTypes'.
	^ self slotTypeClassName asClass
]

{ #category : #accessing }
LcsLocalCollectionSlotBuilder >> slotTypeClassName [
	self deprecated: 'Use slotTypes'.
	^ slotTypeClassName ifNil: [ self slotClass name ]
]

{ #category : #accessing }
LcsLocalCollectionSlotBuilder >> targetModule [
	^ self currentSystem moduleNamed: (self targetModuleName ifNil: [ self targetModuleClass defaultModuleName ])
]

{ #category : #accessing }
LcsLocalCollectionSlotBuilder >> targetModuleName [
	^ targetModuleName
]

{ #category : #accessing }
LcsLocalCollectionSlotBuilder >> targetModuleName: anObject [
	targetModuleName := anObject
]

{ #category : #command }
LcsLocalCollectionSlotBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass removeDomainSlotNamed: self slotName ]
]

{ #category : #command }
LcsLocalCollectionSlotBuilder >> verifyUninstall [
	super verifyUninstall.
	self targetClass ifNotNil: [ self targetClass verifyRemovedDomainSlotNamed: self slotName ]
]
