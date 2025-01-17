Class {
	#name : #LcsDomainClassClassesBuilderJob,
	#superclass : #LcsCodeBuilderJob,
	#instVars : [
		'protoInstances',
		'undefinedClassName',
		'globalCollectionClass'
	],
	#category : #'Lcs-Tools'
}

{ #category : #command }
LcsDomainClassClassesBuilderJob >> buildJobSteps [
	self addJobStep: self domainClassBuilder.
	self addJobStep: self domainUnknownClassBuilder.
	self addJobStep: self domainCollectionClassBuilder.
	self addJobStep: self globalCollectionReferenceSlotBuilder.
	self addJobStep: self globalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses
]

{ #category : #configuration }
LcsDomainClassClassesBuilderJob >> createForRootName: aRootName [
	super createForRootName: aRootName.
	self undefinedClassName: self classPrefix , 'Unknown' , aRootName
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> createInstances: aCollection [
	aCollection do: [ :each | self protoInstances add: each ]
]

{ #category : #builders }
LcsDomainClassClassesBuilderJob >> domainClassBuilder [
	^ LcsDomainClassBuilder new
		newClassName: self domainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #'builder step' }
LcsDomainClassClassesBuilderJob >> domainClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsDomainClassBuilder) first
]

{ #category : #builders }
LcsDomainClassClassesBuilderJob >> domainClassCodeMemberSlotBuilder: eachClass [
	^ LcsMemberOfSlotBuilder new
		target: eachClass;
		collectionSlotName: self globalCollectionSlotName;
		slotName: self domainInstanceSlotName;
		targetModuleClass: self targetModule class;
		addSlotType: (self error: 'Need to fix this');
		yourself
]

{ #category : #builders }
LcsDomainClassClassesBuilderJob >> domainClassMemberSlotBuilder: aTargetClass [
	^ LcsMemberOfSlotBuilder new
		target: aTargetClass;
		collectionSlotName: self globalCollectionSlotName;
		slotName: self domainInstanceSlotName;
		targetModuleClass: self globalCollectionClass;
		targetClassName: aTargetClass name;
		addSlotType: self domainClassName;
		yourself
]

{ #category : #builders }
LcsDomainClassClassesBuilderJob >> domainCollectionClassBuilder [
	^ LcsDomainCollectionClassBuilder new
		newClassName: self globalCollectionClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #builders }
LcsDomainClassClassesBuilderJob >> domainUnknownClassBuilder [
	^ LcsUnknownClassBuilder new
		newClassName: self undefinedClassName;
		targetSuperclassName: self domainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #install }
LcsDomainClassClassesBuilderJob >> execute [ 
	self jobSteps isEmpty ifTrue: [self buildJobSteps].
	self installCode.
	self verifyCodeInstallation.
	self updateSlotModel.
	self verifySlotModelUpdatesMadeByBuilder.
	self currentUnitOfWork applyChanges.
	self populateSlotModel.
	"self verifyPopulateSlotModel".
	self currentUnitOfWork applyChanges
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> globalCollectionClass [
	^ globalCollectionClass
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> globalCollectionClass: anObject [
	globalCollectionClass := anObject
]

{ #category : #builders }
LcsDomainClassClassesBuilderJob >> globalCollectionReferenceSlotBuilder [
	^ LcsGlobalCollectionReferenceSlotBuilder new
		targetClassName: self domainClassName;
		collectionSlotName: self globalCollectionSlotName;
		collectionSlotModuleName: self globalCollectionClass name;
		collectionClassName: self globalCollectionClassName; 
		yourself
]

{ #category : #'builder step' }
LcsDomainClassClassesBuilderJob >> globalCollectionSlotBuilder [
	^ LcsGlobalSlotDefinitionBuilder new
		slotClassName: self globalCollectionClassName;
		slotName: self globalCollectionSlotName;
		targetClassName: self globalCollectionClass name;
		target: self globalCollectionClass;
		collectionElementTypes: { self domainClassName};
		yourself
]

{ #category : #'builder step' }
LcsDomainClassClassesBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsGlobalSlotDefinitionBuilder) first
]

{ #category : #initialize }
LcsDomainClassClassesBuilderJob >> initialize [
	super initialize.
	self protoInstances: OrderedCollection new.
	self targetDomainClasses: Set new
]

{ #category : #initialize }
LcsDomainClassClassesBuilderJob >> installGlobalCollectionSlotInClass: aClass [
	self globalCollectionClass: aClass 
]

{ #category : #command }
LcsDomainClassClassesBuilderJob >> populateSlotModel [
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
LcsDomainClassClassesBuilderJob >> printJobStreamDetailsOn: aStream [
	aStream 
		nextPutAll: 'Install ';
		nextPutAll: self domainClassName ; cr;
		nextPutAll: ' with instances stored in ';
		nextPutAll: self globalCollectionClassName
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> protoInstances [
	^ protoInstances
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> protoInstances: aCollection [
	protoInstances := aCollection
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> undefinedClassName [
	^ undefinedClassName
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> undefinedClassName: anObject [
	undefinedClassName := anObject
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> unknownClass [
	^ self unknownClassBuilderStep installedClass
]

{ #category : #'builder step' }
LcsDomainClassClassesBuilderJob >> unknownClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsUnknownClassBuilder) first
]

{ #category : #command }
LcsDomainClassClassesBuilderJob >> updateSlotModel [
	self jobSteps updateSlotModel.
	self currentSystem currentUnitOfWork applyChanges	
]

{ #category : #command }
LcsDomainClassClassesBuilderJob >> verifySlotModelUpdatesMadeByBuilder [
	self jobSteps verifySlotModelUpdatesMadeByBuilder
]
