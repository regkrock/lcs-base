Class {
	#name : #LcsLocalCollectionSlotBuilder,
	#superclass : #LcsAccessorSlotBuilder,
	#instVars : [
		'slotClass',
		'targetModule',
		'targetModuleName',
		'collectionClass',
		'slotTypeClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #defaults }
LcsLocalCollectionSlotBuilder class >> slotClass [
	^ LcsLocalCollectionSlot
]

{ #category : #'gt views' }
LcsLocalCollectionSlotBuilder >> addAssociationsToUmlModel: aUmlModel [
	super addAssociationsToUmlModel: aUmlModel.
	(aUmlModel classModelForClassname: self targetModuleClass name asString)
		addAssociation: self slotName toModelNamed: self slotTypes first."
	"(aUmlModel classModelForClassname: self slotTypes first)
		addAssociation: 'parent' toModelNamed: self targetClassName
]

{ #category : #'gt views' }
LcsLocalCollectionSlotBuilder >> addCollectionMemberType: aClassName [
	self collectionMemberTypes add: aClassName

]

{ #category : #'code generation' }
LcsLocalCollectionSlotBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
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

{ #category : #accessing }
LcsLocalCollectionSlotBuilder >> collectionClass [
	^ collectionClass
]

{ #category : #accessing }
LcsLocalCollectionSlotBuilder >> collectionClass: anObject [
	collectionClass := anObject
]

{ #category : #accessing }
LcsLocalCollectionSlotBuilder >> collectionMemberTypes [
	^ self properties at: 'collectionMemberTypes' ifAbsent: [ OrderedCollection new ]
]

{ #category : #accessing }
LcsLocalCollectionSlotBuilder >> collectionMemberTypes: anObject [
	self properties at: 'collectionMemberTypes' put: anObject
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
	self collectionMemberTypes:	OrderedCollection new.
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

{ #category : #'gt views' }
LcsLocalCollectionSlotBuilder >> umlModel [
	^ super umlModel
		positions: {(893.654665629069@613.1956787109375). (637.4816652933756@543.0). (643.9736658732096@613.5978393554688). (647.4766680399576@472.40216064453125). (421.66666666666663@620.1956787109375). (864.6096674601237@734.7935180664063). (705.8966662089031@502.00000000000006). (705.8966662089031@572.5978393554688). (503.21408741455525@502.0). (930.8563544660587@642.7935180664063). (930.8563544660587@642.7935180664063). (930.8563544660587@642.7935180664063). (930.8563544660587@642.7935180664063). (930.8563544660587@642.7935180664063). (930.8563544660587@642.7935180664063). (767.8196665445962@628.059948546854). (767.8196665445962@628.059948546854). (767.8196665445962@628.059948546854). (767.8196665445962@628.059948546854). (767.8196665445962@628.059948546854). (767.8196665445962@628.059948546854). (539.654665629069@630.2106698135083). (539.654665629069@630.2106698135083). (539.654665629069@630.2106698135083). (539.654665629069@630.2106698135083). (539.654665629069@630.2106698135083). (539.654665629069@630.2106698135083). (767.8196665445962@603.0056195696627). (767.8196665445962@603.0056195696627). (767.8196665445962@603.0056195696627). (767.8196665445962@603.0056195696627). (767.8196665445962@603.0056195696627). (767.8196665445962@603.0056195696627). (539.654665629069@610.8747782809642). (539.654665629069@610.8747782809642). (539.654665629069@610.8747782809642). (539.654665629069@610.8747782809642). (539.654665629069@610.8747782809642). (539.654665629069@610.8747782809642)};
		yourself
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
