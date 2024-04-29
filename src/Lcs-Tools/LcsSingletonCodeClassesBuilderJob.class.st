Class {
	#name : #LcsSingletonCodeClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#instVars : [
		'codeInstances'
	],
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsSingletonCodeClassesBuilderJob >> codeInstances [
	^ codeInstances
]

{ #category : #accessing }
LcsSingletonCodeClassesBuilderJob >> codeInstances: anObject [
	codeInstances := anObject
]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJob >> createCodeInstances: aCollection [
	aCollection do: [ :each | self codeInstances add: aCollection ]
]

{ #category : #iniitialize }
LcsSingletonCodeClassesBuilderJob >> initialize [
	super initialize.
	self addCodeSuperClassBuilderStep.
	self addCodeSubclassesBuilderJobSteps.
	self addCodeCollectionClassBuilderStep.
	self codeInstances: OrderedCollection new
]
