Class {
	#name : #LcsLocalCollectionSlotDefinitionBuilder,
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
LcsLocalCollectionSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsLocalCollectionSlot
]

{ #category : #'gt views' }
LcsLocalCollectionSlotDefinitionBuilder >> addCollectionElementType: aClassName [
	self collectionElementTypes add: aClassName

]

{ #category : #'code generation' }
LcsLocalCollectionSlotDefinitionBuilder >> addExtraPropertiesTo: aSlotDefinitionMethodBuilder [
	super addExtraPropertiesTo: aSlotDefinitionMethodBuilder.
	self collectionElementTypes do: [ :each |
		aSlotDefinitionMethodBuilder 
			addProperty: 'addCollectionMemberType' 
			value: each ]
]

{ #category : #'gt views' }
LcsLocalCollectionSlotDefinitionBuilder >> addModelAssociationsTo: aCollection [
	aCollection 
		add: self targetModuleClass -> {{self slotName. self slotTypes first.}}
		"add: (self slotTypeClass -> {{'parent'. self targetModuleClass.}})
"
]

{ #category : #'code generation' }
LcsLocalCollectionSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
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
LcsLocalCollectionSlotDefinitionBuilder >> buildJobSteps [
	self slotTypes do: [ :eachClassName | 
		(self classFor: eachClassName) ifNil: [ 
			(self addJobStep: (self domainCollectionClassBuilder: eachClassName)) ] ].
	self collectionElementTypes do: [ :eachClassName | 
		(self classFor: eachClassName) ifNil: [ 
			(self addJobStep: (self domainClassBuilder: eachClassName)).
			(self addJobStep: (self localCollectionReferenceSlotBuilder: eachClassName)) ] ].
	super buildJobSteps
]

{ #category : #'job steps' }
LcsLocalCollectionSlotDefinitionBuilder >> classFor: eachClassName [
	^ [ eachClassName asClass ] on: NotFound do: [ :s | s return: nil ]
]

{ #category : #accessing }
LcsLocalCollectionSlotDefinitionBuilder >> collectionClass [
	^ collectionClass
]

{ #category : #accessing }
LcsLocalCollectionSlotDefinitionBuilder >> collectionClass: anObject [
	collectionClass := anObject
]

{ #category : #accessing }
LcsLocalCollectionSlotDefinitionBuilder >> collectionElementTypes [
	^ collectionElementTypes
]

{ #category : #accessing }
LcsLocalCollectionSlotDefinitionBuilder >> collectionElementTypes: anObject [
	collectionElementTypes := anObject
]

{ #category : #'job steps' }
LcsLocalCollectionSlotDefinitionBuilder >> domainClassBuilder: aClassName [ 
	^ LcsDomainClassBuilder new
		newClassName: aClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #'job steps' }
LcsLocalCollectionSlotDefinitionBuilder >> domainCollectionClassBuilder: aClassName [ 
	^ LcsDomainCollectionClassBuilder new
		newClassName: aClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #initialize }
LcsLocalCollectionSlotDefinitionBuilder >> initialize [
	super initialize.
	self collectionElementTypes:	OrderedCollection new.
	self collectionClass: LcsSmalltalkConfiguration identitySetClass
]

{ #category : #initialize }
LcsLocalCollectionSlotDefinitionBuilder >> initializeModel [
	(self targetClass slotDefinitionNamed: self slotName)
		initializeSlotValueIn: (self currentSystem moduleNamed: self targetModuleName)
]

{ #category : #'job steps' }
LcsLocalCollectionSlotDefinitionBuilder >> localCollectionReferenceSlotBuilder: aClassName [
	^ LcsLocalCollectionReferenceSlotBuilder new
		targetClassName: aClassName;
		collectionSlotName: self slotName;
		addSlotType: self slotTypes first;
		yourself
]

{ #category : #command }
LcsLocalCollectionSlotDefinitionBuilder >> module [
	^ self currentSystem moduleNamed: self targetClass defaultModuleName
]

{ #category : #command }
LcsLocalCollectionSlotDefinitionBuilder >> populateSlotModel [
	super populateSlotModel.

		"| aModule |
	aModule := self module.
	(aModule perform: self getterSelector)
		ifNil: [ aModule initializeSlotNamed: self slotName ]"
]

{ #category : #accessing }
LcsLocalCollectionSlotDefinitionBuilder >> slotClass [
	^ slotClass 
]

{ #category : #accessing }
LcsLocalCollectionSlotDefinitionBuilder >> slotClass: anObject [
	slotClass := anObject
]

{ #category : #accessing }
LcsLocalCollectionSlotDefinitionBuilder >> slotTypeClass [
	self error: 'This is deprecated'.
	^ self slotTypeClassName asClass
]

{ #category : #accessing }
LcsLocalCollectionSlotDefinitionBuilder >> slotTypeClassName [
	^ slotTypeClassName ifNil: [ self slotClass name ]
]

{ #category : #accessing }
LcsLocalCollectionSlotDefinitionBuilder >> targetModule [
	^ self currentSystem moduleNamed: (self targetModuleName ifNil: [ self targetModuleClass defaultModuleName ])
]

{ #category : #accessing }
LcsLocalCollectionSlotDefinitionBuilder >> targetModuleName [
	^ targetModuleName
]

{ #category : #accessing }
LcsLocalCollectionSlotDefinitionBuilder >> targetModuleName: anObject [
	targetModuleName := anObject
]

{ #category : #command }
LcsLocalCollectionSlotDefinitionBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass removeDomainSlotNamed: self slotName ]
]

{ #category : #command }
LcsLocalCollectionSlotDefinitionBuilder >> verifyUninstall [
	super verifyUninstall.
	self targetClass ifNotNil: [ self targetClass verifyRemovedDomainSlotNamed: self slotName ]
]
