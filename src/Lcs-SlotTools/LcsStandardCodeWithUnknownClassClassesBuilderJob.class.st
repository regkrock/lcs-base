Class {
	#name : #LcsStandardCodeWithUnknownClassClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#instVars : [
		'unknownClassName',
		'protoCodes'
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
	self undefinedClassName: self classPrefix , 'Unknown' , aRootName
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
	^ (self jobSteps stepsWithClass: LcsGlobalSlotDefinitionBuilder) first
]

{ #category : #initialize }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> initialize [
	super initialize.
	self protoCodes: OrderedCollection new
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
	self protoCodes
		do: [ :each | 
			self codeClass new
				codeName: each code;
				codeDescription: each description;
				shortName: each label;
				isDefaultInstance: each isDefaultInstance ].
	self currentSystem currentUnitOfWork applyChanges
]

{ #category : #accessing }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> protoCodes [
	^ protoCodes
]

{ #category : #accessing }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> protoCodes: aCollection [
	protoCodes := aCollection
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
	self assert: self targetGlobalCollection collectionSize = (self protoCodes size + 1).
	self protoCodes
		do: [ :each | 
			self assert: (self targetGlobalCollection findWithKey: each code) notNil ].
	self assert: self targetGlobalCollection defaultInstance notNil
]
