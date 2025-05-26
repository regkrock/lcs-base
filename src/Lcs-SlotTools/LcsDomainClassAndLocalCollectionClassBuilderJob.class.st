Class {
	#name : #LcsDomainClassAndLocalCollectionClassBuilderJob,
	#superclass : #LcsDomainClassAndDomainCollectionClassBuilderJob,
	#instVars : [
		'protoInstances',
		'subclassNames'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #command }
LcsDomainClassAndLocalCollectionClassBuilderJob >> addSubclassBuilders [
	self subclassNames do: [ :eachName |
		self addJobStep: (
			LcsDomainClassBuilder new
				newClassName: self classPrefix , eachName;
				targetSuperclassName: self newDomainClassName;
				targetPackageName: self targetPackageName)]
]

{ #category : #command }
LcsDomainClassAndLocalCollectionClassBuilderJob >> buildJobSteps [
	self addJobStep: self domainClassBuilder.
	self buildUnknownClass ifTrue: [
		self addJobStep: self unknownClassBuilder].
	self addSubclassBuilders.
	self addJobStep: self domainCollectionClassBuilder.
	self addJobStep: self localCollectionReferenceSlotBuilder.
	self addJobStep: self localCollectionSlotBuilder
]

{ #category : #accessing }
LcsDomainClassAndLocalCollectionClassBuilderJob >> createForPrefix: aPrefix rootName: aRootName withSubclasses: aCollection [ 
	self createForPrefix: aPrefix rootName: aRootName.
	self subclassNames addAll: aCollection
]

{ #category : #configuration }
LcsDomainClassAndLocalCollectionClassBuilderJob >> createForRootName: aRootName [
	super createForRootName: aRootName.
	self unknownClassName: self classPrefix , 'Unknown' , aRootName
]

{ #category : #accessing }
LcsDomainClassAndLocalCollectionClassBuilderJob >> createInstances: aCollection [
	aCollection do: [ :each | self protoInstances add: each ]
]

{ #category : #builders }
LcsDomainClassAndLocalCollectionClassBuilderJob >> domainClassBuilder [
	^ LcsDomainClassBuilder new
		newClassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #builders }
LcsDomainClassAndLocalCollectionClassBuilderJob >> domainCollectionClassBuilder [
	^ LcsDomainCollectionClassBuilder new
		newClassName: self globalCollectionClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #initialize }
LcsDomainClassAndLocalCollectionClassBuilderJob >> initialize [
	super initialize.
	self protoInstances: OrderedCollection new.
	self targetDomainClasses: Set new.
	self buildUnknownClass: false.
	self subclassNames: OrderedCollection new
]

{ #category : #builders }
LcsDomainClassAndLocalCollectionClassBuilderJob >> localCollectionReferenceSlotBuilder [
	^ LcsLocalCollectionReferenceSlotBuilder new
		targetClassName: self newDomainClassName;
		collectionSlotName: self globalCollectionSlotName;
		"collectionSlotModuleName: self globalCollectionModuleClass defaultModuleName;"
		collectionClassName: self globalCollectionClassName; 
		yourself
]

{ #category : #'builder step' }
LcsDomainClassAndLocalCollectionClassBuilderJob >> localCollectionSlotBuilder [
	^ LcsLocalSlotDefinitionBuilder new
		slotClassName: self globalCollectionClassName;
		slotName: self globalCollectionSlotName;
		targetClassName: self globalCollectionModuleClass name;
		targetModuleClass: self globalCollectionModuleClass;
		collectionElementTypes: { self newDomainClassName};
		yourself
]

{ #category : #printing }
LcsDomainClassAndLocalCollectionClassBuilderJob >> printJobStreamDetailsOn: aStream [
	aStream 
		nextPutAll: 'Install ';
		nextPutAll: self newDomainClassName ; cr;
		nextPutAll: ' with instances stored in ';
		nextPutAll: self globalCollectionClassName
]

{ #category : #accessing }
LcsDomainClassAndLocalCollectionClassBuilderJob >> protoInstances [
	^ protoInstances
]

{ #category : #accessing }
LcsDomainClassAndLocalCollectionClassBuilderJob >> protoInstances: aCollection [
	protoInstances := aCollection
]

{ #category : #accessing }
LcsDomainClassAndLocalCollectionClassBuilderJob >> subclassNames [
	^ subclassNames
]

{ #category : #accessing }
LcsDomainClassAndLocalCollectionClassBuilderJob >> subclassNames: anObject [
	subclassNames := anObject
]

{ #category : #accessing }
LcsDomainClassAndLocalCollectionClassBuilderJob >> unknownClass [
	^ self unknownClassBuilderStep installedClass
]

{ #category : #builders }
LcsDomainClassAndLocalCollectionClassBuilderJob >> unknownClassBuilder [
	^ LcsUnknownClassBuilder new
		newClassName: self unknownClassName;
		targetSuperclassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #'builder step' }
LcsDomainClassAndLocalCollectionClassBuilderJob >> unknownClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsUnknownClassBuilder) first
]

{ #category : #accessing }
LcsDomainClassAndLocalCollectionClassBuilderJob >> unknownClassName [
	^ unknownClassName
]

{ #category : #accessing }
LcsDomainClassAndLocalCollectionClassBuilderJob >> unknownClassName: anObject [
	unknownClassName := anObject
]

{ #category : #verification }
LcsDomainClassAndLocalCollectionClassBuilderJob >> verifyPopulateSlotModel [
	super verifyPopulateSlotModel.
	self protoInstances isEmpty 
		ifTrue: [ ]
		ifFalse: [ self subclassResponsibility ]
]
