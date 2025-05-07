Class {
	#name : #LcsGlobalLocalCollectionBuilderJob,
	#superclass : #LcsDomainClassWithGlobalCollectionBuilderJob,
	#instVars : [
		'protoInstances',
		'unknownClassName',
		'buildUnknownClass',
		'subclassNames'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #command }
LcsGlobalLocalCollectionBuilderJob >> addSubclassBuilders [
	self subclassNames do: [ :eachName |
		self addJobStep: (
			LcsDomainClassBuilder new
				newClassName: self classPrefix , eachName;
				targetSuperclassName: self newDomainClassName;
				targetPackageName: self targetPackageName)]
]

{ #category : #command }
LcsGlobalLocalCollectionBuilderJob >> buildJobSteps [
	self addJobStep: self domainClassBuilder.
	self buildUnknownClass ifTrue: [
		self addJobStep: self domainUnknownClassBuilder].
	self addSubclassBuilders.
	self addJobStep: self domainCollectionClassBuilder.
	self addJobStep: self globalCollectionReferenceSlotBuilder.
	self addJobStep: self globalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses
]

{ #category : #accessing }
LcsGlobalLocalCollectionBuilderJob >> buildUnknownClass [
	^ buildUnknownClass
]

{ #category : #accessing }
LcsGlobalLocalCollectionBuilderJob >> buildUnknownClass: aBoolean [ 
	buildUnknownClass := aBoolean
]

{ #category : #accessing }
LcsGlobalLocalCollectionBuilderJob >> createForPrefix: aPrefix rootName: aRootName withSubclasses: aCollection [ 
	self createForPrefix: aPrefix rootName: aRootName.
	self subclassNames addAll: aCollection
]

{ #category : #configuration }
LcsGlobalLocalCollectionBuilderJob >> createForRootName: aRootName [
	super createForRootName: aRootName.
	self undefinedClassName: self classPrefix , 'Unknown' , aRootName
]

{ #category : #accessing }
LcsGlobalLocalCollectionBuilderJob >> createInstances: aCollection [
	aCollection do: [ :each | self protoInstances add: each ]
]

{ #category : #builders }
LcsGlobalLocalCollectionBuilderJob >> domainClassBuilder [
	^ LcsDomainClassBuilder new
		newClassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #'builder step' }
LcsGlobalLocalCollectionBuilderJob >> domainClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsDomainClassBuilder) first
]

{ #category : #builders }
LcsGlobalLocalCollectionBuilderJob >> domainClassCodeMemberSlotBuilder: aTargetClass [
	^ LcsMemberOfSlotBuilder new
		target: aTargetClass;
		targetClassName: aTargetClass name;
		slotName: self domainInstanceSlotName;
		collectionSlotName: self globalCollectionSlotName;
		targetModuleClass: self globalCollectionModuleClass;
		addSlotType: self newDomainClassName;
		yourself
]

{ #category : #builders }
LcsGlobalLocalCollectionBuilderJob >> domainCollectionClassBuilder [
	^ LcsDomainCollectionClassBuilder new
		newClassName: self globalCollectionClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #builders }
LcsGlobalLocalCollectionBuilderJob >> domainUnknownClassBuilder [
	^ LcsUnknownClassBuilder new
		newClassName: self unknownClassName;
		targetSuperclassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #builders }
LcsGlobalLocalCollectionBuilderJob >> globalCollectionReferenceSlotBuilder [
	^ LcsGlobalCollectionReferenceSlotBuilder new
		targetClassName: self newDomainClassName;
		collectionSlotName: self globalCollectionSlotName;
		collectionSlotModuleName: self globalCollectionModuleClass defaultModuleName;
		collectionClassName: self globalCollectionClassName; 
		yourself
]

{ #category : #'builder step' }
LcsGlobalLocalCollectionBuilderJob >> globalCollectionSlotBuilder [
	^ LcsGlobalSlotDefinitionBuilder new
		slotClassName: self globalCollectionClassName;
		slotName: self globalCollectionSlotName;
		targetClassName: self globalCollectionModuleClass name;
		targetModuleClass: self globalCollectionModuleClass;
		collectionElementTypes: { self newDomainClassName};
		yourself
]

{ #category : #'builder step' }
LcsGlobalLocalCollectionBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsGlobalSlotDefinitionBuilder) first
]

{ #category : #initialize }
LcsGlobalLocalCollectionBuilderJob >> initialize [
	super initialize.
	self protoInstances: OrderedCollection new.
	self targetDomainClasses: Set new.
	self buildUnknownClass: false.
	self subclassNames: OrderedCollection new
]

{ #category : #command }
LcsGlobalLocalCollectionBuilderJob >> populateSlotModel [
	self globalCollectionSlotDefinitionStep populateSlotModel.
	self currentSystem currentUnitOfWork applyChanges.
	self unknownClass new.
	"self protoInstances do: [ :each | 
		self domainClassBuilderStep installedClass new
			isoCode: (each at: 1);
			countryName: (each at: 2)]."
	self currentSystem currentUnitOfWork applyChanges.
]

{ #category : #printing }
LcsGlobalLocalCollectionBuilderJob >> printJobStreamDetailsOn: aStream [
	aStream 
		nextPutAll: 'Install ';
		nextPutAll: self newDomainClassName ; cr;
		nextPutAll: ' with instances stored in ';
		nextPutAll: self globalCollectionClassName
]

{ #category : #accessing }
LcsGlobalLocalCollectionBuilderJob >> protoInstances [
	^ protoInstances
]

{ #category : #accessing }
LcsGlobalLocalCollectionBuilderJob >> protoInstances: aCollection [
	protoInstances := aCollection
]

{ #category : #accessing }
LcsGlobalLocalCollectionBuilderJob >> subclassNames [
	^ subclassNames
]

{ #category : #accessing }
LcsGlobalLocalCollectionBuilderJob >> subclassNames: anObject [
	subclassNames := anObject
]

{ #category : #accessing }
LcsGlobalLocalCollectionBuilderJob >> undefinedClassName: anObject [
	unknownClassName := anObject
]

{ #category : #accessing }
LcsGlobalLocalCollectionBuilderJob >> unknownClass [
	^ self unknownClassBuilderStep installedClass
]

{ #category : #'builder step' }
LcsGlobalLocalCollectionBuilderJob >> unknownClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsUnknownClassBuilder) first
]

{ #category : #accessing }
LcsGlobalLocalCollectionBuilderJob >> unknownClassName [
	^ unknownClassName
]

{ #category : #verification }
LcsGlobalLocalCollectionBuilderJob >> verifyPopulateSlotModel [
	self protoInstances isEmpty 
		ifTrue: [ ]
		ifFalse: [ self subclassResponsibility ]
]
