Class {
	#name : #LcsStandardCodeClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#instVars : [
		'codeInstances'
	],
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> buildJobSteps [
	self addJobStep: self codeClassBuilder.
	self addJobStep: self codeCollectionClassBuilder.
	self addJobStep: self codeParentGlobalCollectionSlotBuilder.
	self addJobStep: self codeGlobalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses
]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> codeInstances [
	^ codeInstances
]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> codeInstances: aCollection [
	codeInstances := aCollection
]

{ #category : #tests }
LcsStandardCodeClassesBuilderJob >> createCodeInstances: aCollection [ 
	self codeInstances addAll: aCollection
]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> initialize [
	super initialize.
	self codeInstances: OrderedCollection new
]
