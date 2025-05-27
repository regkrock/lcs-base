Class {
	#name : #LcsLocalSlotDefinitionBuilder,
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
LcsLocalSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsLocalCollectionSlot
]

{ #category : #'gt views' }
LcsLocalSlotDefinitionBuilder >> addCollectionElementType: aClassName [
	self collectionElementTypes add: aClassName

]

{ #category : #'code generation' }
LcsLocalSlotDefinitionBuilder >> addExtraPropertiesTo: aSlotDefinitionMethodBuilder [
	super addExtraPropertiesTo: aSlotDefinitionMethodBuilder.
	self collectionElementTypes do: [ :each |
		aSlotDefinitionMethodBuilder 
			addProperty: 'addCollectionMemberType' 
			value: each ]
]

{ #category : #'gt views' }
LcsLocalSlotDefinitionBuilder >> addModelAssociationsTo: aCollection [
	aCollection 
		add: (self targetModuleClass -> {{self slotName. self slotTypeClass.}});
		add: (self slotTypeClass -> {{'parent'. self targetModuleClass.}})

]

{ #category : #'code generation' }
LcsLocalSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
	aCodeStream 
		addKeyword: 'addSlotType' argument: self slotTypeClassName.
	self collectionClass notNil ifTrue: [
		aCodeStream
			addKeyword: 'collectionClass' argument: self collectionClass name].
	self collectionElementTypes do: [ :eachClass |
		aCodeStream addKeyword: 'addCollectionMemberType' argument: (eachClass isString ifTrue: [ eachClass ] ifFalse: [ eachClass name ] )].
	self collectionClass isNil ifTrue: [
		aCodeStream addUnaryMessage: 'beIdentitySetCollection']

]

{ #category : #'job steps' }
LcsLocalSlotDefinitionBuilder >> buildJobSteps [
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
LcsLocalSlotDefinitionBuilder >> classFor: eachClassName [
	^ [ eachClassName asClass ] on: NotFound do: [ :s | s return: nil ]
]

{ #category : #accessing }
LcsLocalSlotDefinitionBuilder >> collectionClass [
	^ collectionClass
]

{ #category : #accessing }
LcsLocalSlotDefinitionBuilder >> collectionClass: anObject [
	collectionClass := anObject
]

{ #category : #accessing }
LcsLocalSlotDefinitionBuilder >> collectionElementTypes [
	^ collectionElementTypes
]

{ #category : #accessing }
LcsLocalSlotDefinitionBuilder >> collectionElementTypes: anObject [
	collectionElementTypes := anObject
]

{ #category : #'job steps' }
LcsLocalSlotDefinitionBuilder >> domainClassBuilder: aClassName [ 
	^ LcsDomainClassBuilder new
		newClassName: aClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #'job steps' }
LcsLocalSlotDefinitionBuilder >> domainCollectionClassBuilder: aClassName [ 
	^ LcsDomainCollectionClassBuilder new
		newClassName: aClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #initialize }
LcsLocalSlotDefinitionBuilder >> initialize [
	super initialize.
	self collectionElementTypes:	OrderedCollection new.
	self collectionClass: LcsSmalltalkConfiguration identitySetClass
]

{ #category : #initialize }
LcsLocalSlotDefinitionBuilder >> initializeModel [
	(self targetClass slotDefinitionNamed: self slotName)
		initializeSlotValueIn: (self currentSystem moduleNamed: self targetModuleName)
]

{ #category : #'job steps' }
LcsLocalSlotDefinitionBuilder >> localCollectionReferenceSlotBuilder: aClassName [
	^ LcsLocalCollectionReferenceSlotBuilder new
		targetClassName: aClassName;
		collectionSlotName: self slotName;
		addSlotType: self slotTypes first;
		yourself
]

{ #category : #command }
LcsLocalSlotDefinitionBuilder >> module [
	^ self currentSystem moduleNamed: self targetClass defaultModuleName
]

{ #category : #command }
LcsLocalSlotDefinitionBuilder >> populateSlotModel [
	super populateSlotModel.

		"| aModule |
	aModule := self module.
	(aModule perform: self getterSelector)
		ifNil: [ aModule initializeSlotNamed: self slotName ]"
]

{ #category : #accessing }
LcsLocalSlotDefinitionBuilder >> slotClass [
	^ slotClass 
]

{ #category : #accessing }
LcsLocalSlotDefinitionBuilder >> slotClass: anObject [
	slotClass := anObject
]

{ #category : #accessing }
LcsLocalSlotDefinitionBuilder >> slotClassName: aName [
	slotTypeClassName := aName
]

{ #category : #accessing }
LcsLocalSlotDefinitionBuilder >> slotTypeClass [
	^ self slotTypeClassName asClass
]

{ #category : #accessing }
LcsLocalSlotDefinitionBuilder >> slotTypeClassName [
	^ slotTypeClassName ifNil: [ self slotClass name ]
]

{ #category : #accessing }
LcsLocalSlotDefinitionBuilder >> targetModule [
	^ self currentSystem moduleNamed: (self targetModuleName ifNil: [ self targetModuleClass defaultModuleName ])
]

{ #category : #accessing }
LcsLocalSlotDefinitionBuilder >> targetModuleName [
	^ targetModuleName
]

{ #category : #accessing }
LcsLocalSlotDefinitionBuilder >> targetModuleName: anObject [
	targetModuleName := anObject
]

{ #category : #command }
LcsLocalSlotDefinitionBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass removeDomainSlotNamed: self slotName ]
]

{ #category : #command }
LcsLocalSlotDefinitionBuilder >> verifyUninstall [
	super verifyUninstall.
	self targetClass ifNotNil: [ self targetClass verifyRemovedDomainSlotNamed: self slotName ]
]
