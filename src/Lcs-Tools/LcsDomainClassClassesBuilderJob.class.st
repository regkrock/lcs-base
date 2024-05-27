Class {
	#name : #LcsDomainClassClassesBuilderJob,
	#superclass : #LcsCodeBuilderJob,
	#instVars : [
		'codeSuperclassBuilder',
		'codeCollectionClassBuilder',
		'memberOfSlotBuilder',
		'codeClassBuilders',
		'collectionSlotBuilder'
	],
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> buildJobSteps [
	self addJobStep: self domainClassBuilder.
	self addJobStep: self domainCollectionClassBuilder.
	self addJobStep: self domainParentGlobalCollectionSlotBuilder.
	self addJobStep: self domainGlobalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> codeClassBuilders [
	^ codeClassBuilders
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> codeClassBuilders: anObject [ 
	codeClassBuilders := anObject
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> codeCollectionClassBuilder: anObject [ 
	codeCollectionClassBuilder := anObject
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> codeSuperclassBuilder [
	^ codeSuperclassBuilder
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> codeSuperclassBuilder: anObject [
	codeSuperclassBuilder := anObject
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> collectionSlotBuilder: anObject [
	collectionSlotBuilder := anObject
]

{ #category : #build }
LcsDomainClassClassesBuilderJob >> installMemberSlotInDomainClass: aClass [ 
	self memberOfSlotInDomainClassBuilder target: aClass
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> memberOfSlotBuilder [
	^ memberOfSlotBuilder
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> memberOfSlotBuilder: anObject [ 
	memberOfSlotBuilder := anObject
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> memberOfSlotInDomainClassBuilder [
	^ collectionSlotBuilder
]
