Class {
	#name : #LcsStandardValueObjectWithUnknownClassClassesBuilderJob,
	#superclass : #LcsValueObjectClassesBuilderJob,
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> addCodeSubclassWithRootNamed: aString [
	self addCodeSubclassWithRootNamed: aString with: [ :classBuilder | ]
]

{ #category : #command }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> buildJobSteps [
	self addJobStep: self codeClassBuilder.
	self buildUnknownClass ifTrue: [
		self addJobStep: self unknownClassBuilder].
	self addJobStep: self codesCollectionClassBuilder.
	self addJobStep: self codesLoaderBuilder.
	self addJobStep: self collectionReferenceSlotBuilder.
	self addJobStep: self codesGlobalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses
]

{ #category : #builders }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> codeSubclassBuilderFor: aString [
	^ LcsValueObjectClassBuilder new
		newDomainClassName: (self classPrefix , aString);
		targetSuperclassName: self codeSuperclassBuilder newClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #'job steps' }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> codeSubclassesBuilderJobSteps [
	^ self jobSteps at: 2
]

{ #category : #'job steps' }
LcsStandardValueObjectWithUnknownClassClassesBuilderJob >> codeSuperclassBuilder [
	^ self jobSteps at: 1
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
	^ (self jobSteps stepsWithClass: LcsValueObjectsGlobalSlotDefinitionBuilder) first
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
