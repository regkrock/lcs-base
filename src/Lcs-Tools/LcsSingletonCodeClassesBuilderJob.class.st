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
LcsSingletonCodeClassesBuilderJob >> codeSuperClassParentSlotDefinitionStep [
	^ self jobSteps at: 4
]

{ #category : #'job steps' }
LcsSingletonCodeClassesBuilderJob >> codeSuperclassBuilder [
	^ self jobSteps at: 1
]

{ #category : #'job steps' }
LcsSingletonCodeClassesBuilderJob >> globalCollectionSlotBuilder [
	^ self jobSteps at: 5
]

{ #category : #iniitialize }
LcsSingletonCodeClassesBuilderJob >> initialize [
	super initialize.
	self addCodeSuperClassBuilderStep.
	self addCodeSubclassesBuilderJobSteps.
	self addCodeCollectionClassBuilderStep.
	self addCodeSuperClassParentSlotDefinitionStep.
	self addGlobalCollectionSlotDefinitionBuilderStep.
	self addMemberOfSlotInDomainClassBuilderStep.
]

{ #category : #configuration }
LcsSingletonCodeClassesBuilderJob >> installGlobalCollectionSlotInModuleName: aString [
	super installGlobalCollectionSlotInModuleName: aString.
	self codeSuperClassParentSlotDefinitionStep moduleName: aString
]

{ #category : #'job steps' }
LcsSingletonCodeClassesBuilderJob >> memberOfSlotInDomainClassBuilder [
	^ self jobSteps at: 6
]

{ #category : #'slot model' }
LcsSingletonCodeClassesBuilderJob >> updateSlotModel [
	self codeSuperclassBuilder installedClass withAllSubclassesDo: [ :eachClass | eachClass initializeSlotModel ].
	self codeCollectionClassBuilder installedClass initializeSlotModel.
	self codeSuperClassParentSlotDefinitionStep installSlotDefinition.
	self globalCollectionSlotBuilder installSlotDefinition.
	self memberOfSlotInDomainClassBuilder installSlotDefinition.
	self globalCollectionSlotBuilder initializeModel.
	
	self codeSuperclassBuilder installedClass subclassesDo: [ :each |
		| instance |
		instance := each new.
		instance class ==  self codeSubclassesBuilderJobSteps collection last installedClass ifTrue: [ instance isDefaultInstance: true]
		 ].
	self codeSubclassesBuilderJobSteps collection last .
	self currentSystem currentUnitOfWork applyChanges
	
]
