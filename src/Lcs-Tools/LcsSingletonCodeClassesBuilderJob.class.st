Class {
	#name : #LcsSingletonCodeClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#instVars : [
		'codeInstances'
	],
	#category : #'Lcs-Tools'
}

{ #category : #configuration }
LcsSingletonCodeClassesBuilderJob >> addCodeSubclassWithRootNamed: aString [
	self addCodeSubclassWithRootNamed: aString with: [ :classBuilder | ]
]

{ #category : #configuration }
LcsSingletonCodeClassesBuilderJob >> addCodeSubclassWithRootNamed: aString with: aBlock [
	| classBuilder |
	classBuilder := self codeSubclassBuilderFor: aString.
	aBlock value: classBuilder.
	self codeSubclassesBuilderJobSteps addJobStep: classBuilder
]

{ #category : #'job steps' }
LcsSingletonCodeClassesBuilderJob >> codeCollectionClassBuilder [
	^ self jobSteps at: 3
]

{ #category : #configuration }
LcsSingletonCodeClassesBuilderJob >> codeSubclassBuilderFor: aString [
	^ LcsCodeClassBuilder new
		classPrefix: self classPrefix;
		rootName: aString;
		superclassName: self codeSuperclassBuilder installClassName;
		codePackageName: self codePackageName;
		yourself
]

{ #category : #'job steps' }
LcsSingletonCodeClassesBuilderJob >> codeSubclassesBuilderJobSteps [
	^ self jobSteps at: 2
]

{ #category : #'job steps' }
LcsSingletonCodeClassesBuilderJob >> codeSuperclassBuilder [
	^ self jobSteps at: 1
]

{ #category : #'job steps' }
LcsSingletonCodeClassesBuilderJob >> globalCollectionSlotBuilder [
	^ self jobSteps at: 4
]

{ #category : #iniitialize }
LcsSingletonCodeClassesBuilderJob >> initialize [
	super initialize.
	self addCodeSuperClassBuilderStep.
	self addCodeSubclassesBuilderJobSteps.
	self addCodeCollectionClassBuilderStep.
	self addGlobalCollectionSlotDefinitionBuilderStep.
	self addMemberOfSlotInDomainClassBuilderStep.
]

{ #category : #'job steps' }
LcsSingletonCodeClassesBuilderJob >> memberOfSlotInDomainClassBuilder [
	^ self jobSteps at: 5
]
