Class {
	#name : #LcsStandardCodeWithUnknownClassClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#instVars : [
		'codeInstances',
		'unknownClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> addCodeSubclassWithRootNamed: aString [
	self addCodeSubclassWithRootNamed: aString with: [ :classBuilder | ]
]

{ #category : #command }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> buildJobSteps [
	self addJobStep: self codeClassBuilder.
	self addJobStep: self undefinedCodeClassBuilder.
	self addJobStep: self codeCollectionClassBuilder.
	self addJobStep: self globalCollectionReferenceSlotBuilder.
	self addJobStep: self codeGlobalCollectionSlotBuilder.
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

{ #category : #accessing }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeInstances [
	^ codeInstances
]

{ #category : #accessing }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeInstances: aCollection [
	codeInstances := aCollection
]

{ #category : #populate }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeNameFrom: anArray [ 
	| protoCode |
	protoCode := anArray at: 1.
	protoCode size = 1 ifTrue: [ ^protoCode ].
	^ protoCode asCamelCase asValidSelector asString
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

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> createCodeInstances: aCollection [ 
	self codeInstances addAll: aCollection
]

{ #category : #configuration }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> createForRootName: aRootName [
	super createForRootName: aRootName.
	self undefinedClassName: self classPrefix , 'Unknown' , aRootName
]

{ #category : #'job steps' }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsGlobalSlotDefinitionBuilder) first
]

{ #category : #initialize }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> initialize [
	super initialize.
	self codeInstances: OrderedCollection new
]

{ #category : #populate }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> isDefaultInstanceFrom: anArray [ 
	anArray size < 4 ifTrue: [ ^ false ].
	^ anArray at: 4
]

{ #category : #populate }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> populateSlotModel [
	self globalCollectionSlotDefinitionStep populateSlotModel.
	self unknownClass new
		codeName: 'unknown';
		codeDescription: 'Unknown';
		shortName: 'Unknown';
		isDefaultInstance: true.
	self currentSystem currentUnitOfWork applyChanges.
	self codeInstances
		do: [ :each | 
			self codeClass new
				codeName: (self codeNameFrom: each);
				codeDescription: (self codeDescriptionFrom: each);
				shortName: (self shortNameFrom: each);
				isDefaultInstance: (self isDefaultInstanceFrom: each) ].
	self currentSystem currentUnitOfWork applyChanges
]

{ #category : #accessing }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> undefinedClassName: anObject [ 
	unknownClassName := anObject
]

{ #category : #builders }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> undefinedCodeClassBuilder [
	^ LcsUnknownCodeClassBuilder new
		newClassName: self unknownClassName;
		targetSuperclassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #populate }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> unknownClass [
	^ self unknownCodeClassBuilderStep installedClass
]

{ #category : #accessing }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> unknownClassName [
	^ unknownClassName
]

{ #category : #populate }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> unknownCodeClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsUnknownCodeClassBuilder) first
]

{ #category : #verification }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> verifyPopulateSlotModel [
	self assert: self targetGlobalCollection parent == self targetModule.
	self assert: self targetGlobalCollection size = (self codeInstances size + 1).
	self codeInstances
		do: [ :each | 
			self assert: (self targetGlobalCollection findWithKey: (self codeNameFrom: each)) notNil ].
	self assert: self targetGlobalCollection defaultInstance notNil
]
