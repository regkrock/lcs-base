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

{ #category : #builders }
LcsSingletonCodeClassesBuilderJob >> buildJobSteps [
	self addJobStep: self codeClassBuilder.
	self addCodeSubclassBuilders.
	self addJobStep: self codeCollectionClassBuilder.
	self addJobStep: self codeParentGlobalCollectionSlotBuilder.
	self addJobStep: self codeGlobalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses
]

{ #category : #builders }
LcsSingletonCodeClassesBuilderJob >> codeClassBuilder [
	^ super codeClassBuilder
		superclassName: 'LcsSingletonCode';
		yourself
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

{ #category : #iniitialize }
LcsSingletonCodeClassesBuilderJob >> initialize [
	super initialize.
	self codeSubclassBuilders: OrderedCollection new
]

{ #category : #'slot model' }
LcsSingletonCodeClassesBuilderJob >> populateSlotModel [
	self globalCollectionSlotDefinitionBuilder populateSlotModel.
	self currentSystem currentUnitOfWork applyChanges.
	self singletonClassBuilders do: [ :eachStep | eachStep populateSlotModel ].
	self currentSystem currentUnitOfWork applyChanges
]

{ #category : #'slot model' }
LcsSingletonCodeClassesBuilderJob >> singletonClassBuilders [
	^ self jobSteps stepsWithClass: LcsSingletonCodeClassBuilder
]

{ #category : #'slot model' }
LcsSingletonCodeClassesBuilderJob >> verifyPopulateSlotModel [
	self assert: self targetGlobalCollection parent == self module.
	self assert: self targetGlobalCollection size = self singletonClassBuilders size.
	self singletonClassBuilders
		do: [ :eachStep | 
			self assert: (self targetGlobalCollection findWithKey: eachStep codeName) notNil ].
	self assert: self targetGlobalCollection defaultInstance notNil
]
