Class {
	#name : #LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob,
	#superclass : #LcsDomainClassAndDomainCollectionClassBuilderJob,
	#instVars : [
		'protoInstances',
		'subclassNames'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #'gt views' }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> addRefactoringTextDetailsTo: aStream [
	self jobSteps do: [ :each |
		aStream nextPutAll: '---- Step: ' , each stepNumber , ' ----'; cr; cr.
		each addRefactoringTextDetailsTo: aStream ] separatedBy: [ aStream cr; cr ]
]

{ #category : #command }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> addSubclassBuilders [
	self subclassNames do: [ :eachName |
		self addJobStep: (
			LcsDomainClassBuilder new
				newClassName: self classPrefix , eachName;
				targetSuperclassName: self newDomainClassName;
				targetPackageName: self targetPackageName)]
]

{ #category : #command }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> buildJobSteps [
	self addJobStep: self domainClassBuilder.
	self buildUnknownClass ifTrue: [
		self addJobStep: self unknownClassBuilder].
	self addSubclassBuilders.
	self addJobStep: self domainCollectionClassBuilder.
	self addJobStep: self localCollectionSlotBuilder.
	self addJobStep: self loaderBuilder.
	self addJobStep: self collectionReferenceSlotBuilder.
	self addJobStep: self collectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses.
]

{ #category : #builders }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> collectionReferenceSlotBuilder [
	^ LcsGlobalCollectionReferenceSlotBuilder new
		targetClassName: self newDomainClassName;
		collectionSlotName: self collectionSlotName;
		collectionSlotModuleName: self collectionModuleClass defaultModuleName;
		collectionClassName: self collectionClassName; 
		addSlotType: self collectionClassName;
		yourself
]

{ #category : #'builder step' }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> collectionSlotBuilder [
	| builder |
	builder := LcsGlobalCollectionSlotBuilder new
					slotName: self collectionSlotName;
					targetClassName: self collectionModuleClass name;
					targetModuleClass: self collectionModuleClass;
					collectionMemberTypes: (OrderedCollection with:  self newDomainClassName);
					addSlotType: self collectionClassName;
					yourself.
	self buildUnknownClass ifTrue: [
		builder addJobStep: (
			LcsAccessorSlotBuilder new
				slotClassName: LcsAccessorSlot name;
				slotName: 'unknown';
				targetClassName: self collectionClassName;
				addSlotType: self unknownClassName;
				yourself)].
	^ builder
]

{ #category : #accessing }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> createForPrefix: aPrefix rootName: aRootName withSubclasses: aCollection [ 
	self createForPrefix: aPrefix rootName: aRootName.
	self subclassNames addAll: aCollection
]

{ #category : #configuration }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> createForRootName: aRootName [
	super createForRootName: aRootName.
	self unknownClassName: self classPrefix , 'Unknown' , aRootName
]

{ #category : #accessing }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> createInstances: aCollection [
	aCollection do: [ :each | self protoInstances add: each ]
]

{ #category : #builders }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> domainClassBuilder [
	^ LcsDomainClassBuilder new
		newClassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #'builder step' }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> domainClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsDomainClassBuilder) first
]

{ #category : #builders }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> domainClassCodeMemberSlotBuilder: aTargetClass [
	^ LcsMemberOfSlotBuilder new
		target: aTargetClass;
		targetClassName: aTargetClass name;
		slotName: self domainInstanceSlotName;
		collectionSlotName: self collectionSlotName;
		targetModuleClass: self collectionModuleClass;
		addSlotType: self newDomainClassName;
		yourself
]

{ #category : #builders }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> domainCollectionClassBuilder [
	^ LcsDomainCollectionClassBuilder new
		newClassName: self collectionClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #configuration }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> generateRelatedNames [
	super generateRelatedNames.
	(self classRootName isNil or: [ self classPrefix isNil ])
		ifTrue: [
			self unknownClassName: nil.
			^self ].
	self unknownClassName: self classPrefix , 'Unknown' , self classRootName
]

{ #category : #'builder step' }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsGlobalCollectionSlotBuilder) first
]

{ #category : #'gt views' }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ];
		actionUpdateButton
]

{ #category : #initialize }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> initialize [
	super initialize.
	self protoInstances: OrderedCollection new.
	self targetDomainClasses: Set new.
	self buildUnknownClass: false.
	self subclassNames: OrderedCollection new
]

{ #category : #'as yet unclassified' }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> loaderBuilder [
	^ LcsLoaderClassBuilder new
		newClassName: self collectionClassName , 'Loader';
		instanceClassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #builders }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> localCollectionSlotBuilder [
	^ LcsLocalCollectionSlotBuilder new
		slotName: self collectionSlotName;
		addSlotType: self collectionClassName;
		targetClassName: self collectionModuleClass name;
		targetModuleClass: self collectionModuleClass;
		targetPackageName: self targetPackageName;
		collectionMemberTypes: (OrderedCollection with: self newDomainClassName);
		addSlotType: self collectionClassName;
		yourself
]

{ #category : #printing }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> printJobStreamDetailsOn: aStream [
	aStream 
		nextPutAll: 'Install ';
		nextPutAll: (self newDomainClassName) printString ; cr;
		nextPutAll: ' with instances stored in ';
		nextPutAll: (self collectionClassName) printString
]

{ #category : #accessing }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> protoInstances [
	^ protoInstances
]

{ #category : #accessing }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> protoInstances: aCollection [
	protoInstances := aCollection
]

{ #category : #'gt views' }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> refactoringText [
	| stream |
	stream := WriteStream on: String new.
	self addRefactoringTextDetailsTo: stream.
	^ stream contents
]

{ #category : #accessing }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> subclassNames [
	^ subclassNames
]

{ #category : #accessing }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> subclassNames: anObject [
	subclassNames := anObject
]

{ #category : #builders }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> unknownClassBuilder [
	^ LcsUnknownClassBuilder new
		newClassName: self unknownClassName;
		targetSuperclassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #'builder step' }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> unknownClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsUnknownClassBuilder) ifEmpty: [ nil ] ifNotEmpty: [ :coll | coll first ]
]

{ #category : #accessing }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> unknownClassName [
	^ unknownClassName
]

{ #category : #accessing }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> unknownClassName: anObject [
	unknownClassName := anObject
]

{ #category : #verification }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob >> verifyPopulateSlotModel [
	super verifyPopulateSlotModel.
	self protoInstances isEmpty 
		ifTrue: [ ]
		ifFalse: [ self subclassResponsibility ]
]
