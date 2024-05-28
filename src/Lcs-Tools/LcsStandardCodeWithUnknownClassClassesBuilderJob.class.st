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
LcsStandardCodeWithUnknownClassClassesBuilderJob >> globalCollectionSlotBuilder [
	^ self jobSteps at: 4
]

{ #category : #accessing }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> initialize [
	super initialize.
	self codeInstances: OrderedCollection new
]

{ #category : #'job steps' }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> memberOfSlotInDomainClassBuilder [
	^ self jobSteps at: 5
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
