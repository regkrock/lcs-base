Class {
	#name : #LcsSingletonValueObjectClassesBuilderJob,
	#superclass : #LcsValueObjectClassesBuilderJob,
	#instVars : [
		'codeSubclassBuilders'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #builders }
LcsSingletonValueObjectClassesBuilderJob >> addCodeSubclassBuilders [
	self codeSubclassBuilders
		do: [ :eachBuilder | self addJobStep: (
				eachBuilder
					targetSuperclassName: self newDomainClassName;
					targetPackageName: self targetPackageName;
					yourself) ]
]

{ #category : #configuration }
LcsSingletonValueObjectClassesBuilderJob >> addCodeSubclassWithRootNamed: aString [
	self addCodeSubclassWithRootNamed: aString with: [ :classBuilder | ]
]

{ #category : #command }
LcsSingletonValueObjectClassesBuilderJob >> buildJobSteps [
	self addJobStep: self codeClassBuilder.
	self addCodeSubclassBuilders.
	self addJobStep: self codesCollectionClassBuilder.
	self addJobStep: self collectionReferenceSlotBuilder.
	self addJobStep: self codesGlobalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses
]

{ #category : #builders }
LcsSingletonValueObjectClassesBuilderJob >> codeClassBuilder [
	^ super codeClassBuilder
		targetSuperclassName: 'LcsSingletonValueObject';
		yourself
]

{ #category : #builders }
LcsSingletonValueObjectClassesBuilderJob >> codeSubclassBuilderFor: aString [
	^ LcsSingletonValueObjectClassBuilder new
		rootName: aString;
		description: aString;
		newClassName: self classPrefix , aString;
		targetSuperclassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #accessing }
LcsSingletonValueObjectClassesBuilderJob >> codeSubclassBuilders [
	^ codeSubclassBuilders
]

{ #category : #accessing }
LcsSingletonValueObjectClassesBuilderJob >> codeSubclassBuilders: aCollection [
	codeSubclassBuilders := aCollection
]

{ #category : #builders }
LcsSingletonValueObjectClassesBuilderJob >> codesGlobalCollectionSlotBuilder [
	^ LcsSingletonValueObjectsGlobalCollectionSlotBuilder new
		slotName: self collectionSlotName;
		targetClassName: self collectionModuleClass name;
		targetModuleClass: self collectionModuleClass;
		codeSuperclassName: self newDomainClassName;
		addSlotType: self collectionClassName;
		yourself
]

{ #category : #'builder step' }
LcsSingletonValueObjectClassesBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsSingletonValueObjectsGlobalCollectionSlotBuilder) first
]

{ #category : #initialize }
LcsSingletonValueObjectClassesBuilderJob >> initialize [
	super initialize.
	self codeSubclassBuilders: OrderedCollection new
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

{ #category : #command }
LcsSingletonValueObjectClassesBuilderJob >> verifyPopulateSlotModel [
	super verifyPopulateSlotModel.
	self assert: self targetGlobalCollection parent == self targetModule.
	self assert: self targetGlobalCollection collectionSize = self singletonClassBuilders size.
	self singletonClassBuilders
		do: [ :eachStep | 
			self assert: (self targetGlobalCollection findWithKey: eachStep code) notNil ].
	self assert: self targetGlobalCollection defaultInstance notNil
]
