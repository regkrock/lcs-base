Class {
	#name : #LcsSingletonValueObjectClassesBuilderJob,
	#superclass : #LcsValueObjectClassesBuilderJob,
	#instVars : [
		'valueObjectSubclassBuilders'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #builders }
LcsSingletonValueObjectClassesBuilderJob >> addValueObjectSubclassBuilders [
	self valueObjectSubclassBuilders
		do: [ :eachBuilder | self addJobStep: (
				eachBuilder
					targetSuperclassName: self newDomainClassName;
					targetPackageName: self targetPackageName;
					yourself) ]
]

{ #category : #configuration }
LcsSingletonValueObjectClassesBuilderJob >> addValueObjectSubclassWithRootNamed: aString [
	self addValueObjectSubclassWithRootNamed: aString with: [ :classBuilder | ]
]

{ #category : #command }
LcsSingletonValueObjectClassesBuilderJob >> buildJobSteps [
	self addJobStep: self valueObjectClassBuilder.
	self addValueObjectSubclassBuilders.
	self addJobStep: self valueObjectsCollectionClassBuilder.
	self addJobStep: self collectionReferenceSlotBuilder.
	self addJobStep: self valueObjectsGlobalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses
]

{ #category : #'builder step' }
LcsSingletonValueObjectClassesBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsSingletonValueObjectsGlobalCollectionSlotBuilder) first
]

{ #category : #initialize }
LcsSingletonValueObjectClassesBuilderJob >> initialize [
	super initialize.
	self valueObjectsSubclassBuilders: OrderedCollection new
]

{ #category : #'gt views' }
LcsSingletonValueObjectClassesBuilderJob >> overview [
	| collection |
	collection := OrderedCollection new.
	collection add: 'Superclass' -> 1 .
	
	^collection.
	
]

{ #category : #printing }
LcsSingletonValueObjectClassesBuilderJob >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: 'Create and populate classes related to ';
		nextPutAll: self newDomainClassName asString
]

{ #category : #builders }
LcsSingletonValueObjectClassesBuilderJob >> singletonClassBuilders [
	^ self jobSteps stepsWithClass: LcsSingletonValueObjectClassBuilder
]

{ #category : #builders }
LcsSingletonValueObjectClassesBuilderJob >> valueObjectClassBuilder [
	^ super valueObjectClassBuilder
		targetSuperclassName: 'LcsSingletonValueObject';
		yourself
]

{ #category : #builders }
LcsSingletonValueObjectClassesBuilderJob >> valueObjectSubclassBuilderFor: aString [
	^ LcsSingletonValueObjectClassBuilder new
		rootName: aString;
		description: aString;
		newClassName: self classPrefix , aString;
		targetSuperclassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #accessing }
LcsSingletonValueObjectClassesBuilderJob >> valueObjectSubclassBuilders [
	^ valueObjectSubclassBuilders
]

{ #category : #builders }
LcsSingletonValueObjectClassesBuilderJob >> valueObjectsGlobalCollectionSlotBuilder [
	^ LcsSingletonValueObjectsGlobalCollectionSlotBuilder new
		slotName: self collectionSlotName;
		targetClassName: self collectionModuleClass name;
		targetModuleClass: self collectionModuleClass;
		valueObjectSuperclassName: self newDomainClassName;
		addSlotType: self collectionClassName;
		yourself
]

{ #category : #accessing }
LcsSingletonValueObjectClassesBuilderJob >> valueObjectsSubclassBuilders: aCollection [
	valueObjectSubclassBuilders := aCollection
]

{ #category : #command }
LcsSingletonValueObjectClassesBuilderJob >> verifyPopulateSlotModel [
	super verifyPopulateSlotModel.
	self assert: self targetGlobalCollection parent == self targetModule.
	self assert: self targetGlobalCollection collectionSize = self singletonClassBuilders size.
	self singletonClassBuilders do: [ :eachStep | 
		self assert: (self targetGlobalCollection findWithKey: eachStep code) notNil ].
	self assert: self targetGlobalCollection defaultInstance notNil
]
