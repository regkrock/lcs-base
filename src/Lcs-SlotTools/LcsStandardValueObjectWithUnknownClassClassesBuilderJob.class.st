Class {
	#name : #LcsStandardValueObjectWithUnknownClassClassesBuilderJob,
	#superclass : #LcsValueObjectClassesBuilderJob,
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> addValueObjectSubclassWithRootNamed: aString [
	self addValueObjectSubclassWithRootNamed: aString with: [ :classBuilder | ]
]

{ #category : #command }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> buildJobSteps [
	self addJobStep: self valueObjectClassBuilder.
	self buildUnknownClass ifTrue: [
		self addJobStep: self unknownClassBuilder].
	self addJobStep: self valueObjectsCollectionClassBuilder.
	self addJobStep: self valueObjectsLoaderBuilder.
	self addJobStep: self collectionReferenceSlotBuilder.
	self addJobStep: self valueObjectsGlobalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses
]

{ #category : #configuration }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> createForRootName: aRootName [
	super createForRootName: aRootName.
	self unknownClassName: self classPrefix , 'Unknown' , aRootName
]

{ #category : #tests }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> createProtoCodesFromLabels: aCollection [ 
	aCollection do: [ :eachLabel | 
		self protoCodes add: (
			eachLabel isEmpty 
				ifTrue: [ LcsProtoCode unknown]
				ifFalse: [ LcsProtoCode newFromLabel: eachLabel]) ]
]

{ #category : #'job steps' }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsValueObjectsGlobalCollectionSlotBuilder) first
]

{ #category : #initialize }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> initialize [
	super initialize.
	self protoCodes: OrderedCollection new
]

{ #category : #populate }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> unknownClass [
	^ self unknownCodeClassBuilderStep installedClass
]

{ #category : #builders }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> unknownClassBuilder [
	^ LcsUnknownClassBuilder new
		newClassName: self unknownClassName;
		targetSuperclassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #accessing }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> unknownClassName [
	^ unknownClassName
]

{ #category : #accessing }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> unknownClassName: anObject [ 
	unknownClassName := anObject
]

{ #category : #populate }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> unknownCodeClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsSingletonUnknownValueObjectClassBuilder) first
]

{ #category : #builders }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> valueObjectSubclassBuilderFor: aString [
	^ LcsValueObjectClassBuilder new
		newDomainClassName: (self classPrefix , aString);
		targetSuperclassName: self valueObjectSuperclassBuilder newClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #'job steps' }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> valueObjectSuperclassBuilder [
	^ self jobSteps at: 1
]

{ #category : #verification }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> verifyPopulateSlotModel [
	super verifyPopulateSlotModel.
	self assert: self targetGlobalCollection parent == self targetModule.
	self assert: self targetGlobalCollection collectionSize = self protoCodes size.
	self protoCodes
		do: [ :each | 
			self assert: (self targetGlobalCollection findWithKey: each code) notNil ].
	self assert: self targetGlobalCollection defaultInstance notNil
]
