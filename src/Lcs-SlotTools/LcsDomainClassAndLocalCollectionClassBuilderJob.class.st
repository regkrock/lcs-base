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
	self addJobStep: self collectionSlotBuilder
]

{ #category : #builders }
LcsDomainClassAndLocalCollectionClassBuilderJob >> collectionReferenceSlotBuilder [
	^ LcsLocalCollectionReferenceSlotBuilder new
		targetClassName: self newDomainClassName;
		collectionSlotName: self collectionSlotName;
		addSlotType: self collectionClassName;
		collectionClassName: self collectionClassName; 
		yourself
]

{ #category : #'builder step' }
LcsDomainClassAndLocalCollectionClassBuilderJob >> collectionSlotBuilder [
	^ LcsLocalCollectionSlotDefinitionBuilder new
		slotName: self collectionSlotName;
		addSlotType: self collectionClassName;
		targetClassName: self collectionModuleClass name;
		targetModuleClass: self collectionModuleClass;
		targetPackageName: self targetPackageName;
		collectionElementTypes: { self newDomainClassName};
		addSlotType: self collectionClassName;
		yourself
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
		newClassName: self collectionClassName;
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

{ #category : #printing }
LcsDomainClassAndLocalCollectionClassBuilderJob >> printJobStreamDetailsOn: aStream [
	aStream 
		nextPutAll: 'Install ';
		nextPutAll: self newDomainClassName ; cr;
		nextPutAll: ' with instances stored in ';
		nextPutAll: self collectionClassName
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
