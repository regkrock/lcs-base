Class {
	#name : #LcsStandardCodeWithUnknownClassClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> addCodeSubclassWithRootNamed: aString [
	self addCodeSubclassWithRootNamed: aString with: [ :classBuilder | ]
]

{ #category : #command }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> buildJobSteps [
	self addJobStep: self codeClassBuilder.
	self buildUnknownClass ifTrue: [
		self addJobStep: self unknownClassBuilder].
	self addJobStep: self codesCollectionClassBuilder.
	self addJobStep: self codesLoaderBuilder.
	self addJobStep: self collectionReferenceSlotBuilder.
	self addJobStep: self codesGlobalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses
]

{ #category : #populate }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeClass [
	^ self codeClassBuilderStep installedClass
]

{ #category : #populate }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsCodeSuperClassBuilder) first
]

{ #category : #builders }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeSubclassBuilderFor: aString [
	^ LcsCodeClassBuilder new
		newDomainClassName: (self classPrefix , aString);
		targetSuperclassName: self codeSuperclassBuilder newClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #'job steps' }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeSubclassesBuilderJobSteps [
	^ self jobSteps at: 2
]

{ #category : #'job steps' }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeSuperclassBuilder [
	^ self jobSteps at: 1
]

{ #category : #configuration }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> createForRootName: aRootName [
	super createForRootName: aRootName.
	self unknownClassName: self classPrefix , 'Unknown' , aRootName
]

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> createProtoCodesFromLabels: aCollection [ 
	aCollection do: [ :eachLabel | 
		self protoCodes add: (
			eachLabel isEmpty 
				ifTrue: [ LcsProtoCode unknown]
				ifFalse: [ LcsProtoCode newFromLabel: eachLabel]) ]
]

{ #category : #'job steps' }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsCodesGlobalSlotDefinitionBuilder) first
]

{ #category : #initialize }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> initialize [
	super initialize.
	self protoCodes: OrderedCollection new
]

{ #category : #populate }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> unknownClass [
	^ self unknownCodeClassBuilderStep installedClass
]

{ #category : #builders }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> unknownClassBuilder [
	^ LcsUnknownClassBuilder new
		newClassName: self unknownClassName;
		targetSuperclassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #accessing }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> unknownClassName [
	^ unknownClassName
]

{ #category : #accessing }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> unknownClassName: anObject [ 
	unknownClassName := anObject
]

{ #category : #populate }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> unknownCodeClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsSingletonUnknownCodeClassBuilder) first
]

{ #category : #verification }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> verifyPopulateSlotModel [
	super verifyPopulateSlotModel.
	self assert: self targetGlobalCollection parent == self targetModule.
	self assert: self targetGlobalCollection collectionSize = self protoCodes size.
	self protoCodes
		do: [ :each | 
			self assert: (self targetGlobalCollection findWithKey: each code) notNil ].
	self assert: self targetGlobalCollection defaultInstance notNil
]
