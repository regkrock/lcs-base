Class {
	#name : #LcsSingletonCodeClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#instVars : [
		'codeSubclassBuilders'
	],
	#category : #'Lcs-Tools'
}

{ #category : #builders }
LcsSingletonCodeClassesBuilderJob >> addCodeSubclassBuilders [
	self codeSubclassBuilders
		do: [ :eachBuilder | 
			self
				addJobStep: (eachBuilder
						superclassName: self codeClassName;
						codePackageName: self codePackageName;
						yourself) ]
]

{ #category : #configuration }
LcsSingletonCodeClassesBuilderJob >> addCodeSubclassWithRootNamed: aString [
	self addCodeSubclassWithRootNamed: aString with: [ :classBuilder | ]
]

{ #category : #configuration }
LcsSingletonCodeClassesBuilderJob >> addCodeSubclassWithRootNamed: aString with: aBlock [
	| classBuilder |
	classBuilder := self codeSubclassBuilderFor: aString.
	aBlock value: classBuilder.
	self codeSubclassBuilders add: classBuilder
]

{ #category : #builders }
LcsSingletonCodeClassesBuilderJob >> buildJobSteps [
	self addJobStep: self codeClassBuilder.
	self addCodeSubclassBuilders.
	self addJobStep: self codeCollectionClassBuilder.
	self addJobStep: self codeParentGlobalCollectionSlotBuilder.
	self addJobStep: self codeGlobalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses
]

{ #category : #configuration }
LcsSingletonCodeClassesBuilderJob >> codeSubclassBuilderFor: aString [
	^ LcsSingletonCodeClassBuilder new
		rootName: aString;
		newClassName: self classPrefix , aString;
		superclassName: self codeClassName;
		codePackageName: self codePackageName;
		yourself
]

{ #category : #accessing }
LcsSingletonCodeClassesBuilderJob >> codeSubclassBuilders [
	^ codeSubclassBuilders
]

{ #category : #accessing }
LcsSingletonCodeClassesBuilderJob >> codeSubclassBuilders: aCollection [
	codeSubclassBuilders := aCollection
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

{ #category : #'slot model' }
LcsSingletonCodeClassesBuilderJob >> globalCollectionSlotBuilders [
	^ (self jobSteps stepsWithClass: LcsGlobalSlotDefinitionBuilder)
		do: [ :each | each populateSlotModel ]
]

{ #category : #iniitialize }
LcsSingletonCodeClassesBuilderJob >> initialize [
	super initialize.
	self codeSubclassBuilders: OrderedCollection new
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
LcsSingletonCodeClassesBuilderJob >> populateSlotModel [
	self jobSteps populateSlotModel.
	self currentSystem currentUnitOfWork applyChanges
]

{ #category : #'slot model' }
LcsSingletonCodeClassesBuilderJob >> singletonClassBuilders [
	^ (self jobSteps stepsWithClass: LcsGlobalSlotDefinitionBuilder)
		do: [ :each | each populateSlotModel ]
]

{ #category : #'slot model' }
LcsSingletonCodeClassesBuilderJob >> updateSlotModel [
	self jobSteps updateSlotModel.
	self currentSystem currentUnitOfWork applyChanges	
]

{ #category : #'slot model' }
LcsSingletonCodeClassesBuilderJob >> verifyInstallation [
	self jobSteps verifyInstallation
]

{ #category : #'slot model' }
LcsSingletonCodeClassesBuilderJob >> verifySlotModelUpdates [
	self jobSteps verifySlotModelUpdates
]
