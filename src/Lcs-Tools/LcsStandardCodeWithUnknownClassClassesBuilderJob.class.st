Class {
	#name : #LcsStandardCodeWithUnknownClassClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#instVars : [
		'codeInstances',
		'undefinedClassName'
	],
	#category : #'Lcs-Tools'
}

{ #category : #configuration }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> addCodeSubclassWithRootNamed: aString [
	self addCodeSubclassWithRootNamed: aString with: [ :classBuilder | ]
]

{ #category : #accessing }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> buildJobSteps [
	self addJobStep: self codeClassBuilder.
	self addJobStep: self undefinedCodeClassBuilder.
	self addJobStep: self codeCollectionClassBuilder.
	self addJobStep: self codeParentGlobalCollectionSlotBuilder.
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

{ #category : #configuration }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeRootName: aRootName [
	super codeRootName: aRootName.
	self undefinedClassName: self classPrefix , 'Unknown' , aRootName
]

{ #category : #configuration }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeSubclassBuilderFor: aString [
	^ LcsCodeClassBuilder new
		codeClassName: (self classPrefix , aString);
		superclassName: self codeSuperclassBuilder newClassName;
		codePackageName: self codePackageName;
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

{ #category : #'job steps' }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> globalCollectionSlotDefinitionBuilder [
	^ (self jobSteps stepsWithClass: LcsGlobalSlotDefinitionBuilder) first
]

{ #category : #accessing }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> initialize [
	super initialize.
	self codeInstances: OrderedCollection new
]

{ #category : #populate }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> isDefaultInstanceFrom: anArray [ 
	anArray size < 4 ifTrue: [ ^ false ].
	^ anArray at: 4
]

{ #category : #'job steps' }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> memberOfSlotInDomainClassBuilder [
	^ self jobSteps at: 5
]

{ #category : #populate }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> populateSlotModel [
	self globalCollectionSlotDefinitionBuilder populateSlotModel.
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

{ #category : #configuration }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> undefinedClassName [
	^ undefinedClassName
]

{ #category : #configuration }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> undefinedClassName: anObject [ 
	undefinedClassName := anObject
]

{ #category : #builders }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> undefinedCodeClassBuilder [
	^ LcsUnknownCodeClassBuilder new
		newClassName: self undefinedClassName;
		superclassName: self codeClassName;
		codePackageName: self codePackageName;
		yourself
]

{ #category : #populate }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> unknownClass [
	^ self unknownCodeClassBuilderStep installedClass
]

{ #category : #populate }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> unknownCodeClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsUnknownCodeClassBuilder) first
]

{ #category : #verification }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> verifyPopulateSlotModel [
	self assert: self targetGlobalCollection parent == self module.
	self assert: self targetGlobalCollection size = (self codeInstances size + 1).
	self codeInstances
		do: [ :each | 
			self assert: (self targetGlobalCollection findWithKey: (self codeNameFrom: each)) notNil ].
	self assert: self targetGlobalCollection defaultInstance notNil
]
