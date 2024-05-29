Class {
	#name : #LcsCodeClassesBuilderJob,
	#superclass : #LcsCodeBuilderJob,
	#instVars : [
		'codeClassRootName',
		'codeSlotName',
		'codeClassName',
		'codeCollectionClassName',
		'codeCollectionSlotName',
		'moduleClass',
		'targetDomainClasses'
	],
	#category : #'Lcs-Tools'
}

{ #category : #configuration }
LcsCodeClassesBuilderJob >> addCodeSubclassWithRootNamed: aString with: aBlock [
	| classBuilder |
	classBuilder := self codeSubclassBuilderFor: aString.
	aBlock value: classBuilder.
	self codeSubclassBuilders add: classBuilder
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> addMemberOfSlotBuilderForTargetClasses [
	self targetDomainClasses
		do: [ :eachClass | self addJobStep: (self domainClassCodeMemberSlotBuilder: eachClass) ]
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> codeClassBuilder [
	^ LcsCodeSuperClassBuilder new
		newClassName: self codeClassName;
		codePackageName: self codePackageName;
		yourself
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeClassName [
	^ codeClassName
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeClassName: anObject [ 
	codeClassName := anObject
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeClassRootName [
	^ codeClassRootName
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeClassRootName: anObject [
	codeClassRootName := anObject
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> codeCollectionClassBuilder [
	^ LcsCodeCollectionClassBuilder new
		newClassName: self codeCollectionClassName;
		codePackageName: self codePackageName;
		yourself
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeCollectionClassName [
	^ codeCollectionClassName
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeCollectionClassName: anObject [ 
	codeCollectionClassName := anObject
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeCollectionSlotName [
	^ codeCollectionSlotName
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeCollectionSlotName: aString [
	codeCollectionSlotName := aString
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeDescriptionFrom: anArray [
	anArray size < 2 ifTrue: [ ^ (anArray at: 1) capitalized ].
	^ anArray at: 2
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> codeGlobalCollectionSlotBuilder [
	^ LcsGlobalSlotDefinitionBuilder new
		slotClassName: self codeCollectionClassName;
		slotName: self codeCollectionSlotName;
		moduleClass: self moduleClass;
		yourself
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeNameFrom: anArray [
	(anArray at: 1) first isLowercase ifTrue: [ ^ anArray at: 1 ].
	^ (anArray at: 1) first asString asLowercase , ((anArray at: 1) copyFrom: 2 to: (anArray at: 1) size)
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> codeParentGlobalCollectionSlotBuilder [
	^ LcsGlobalCollectionReferenceSlotBuilder new
		targetClassName: self codeClassName;
		collectionSlotName: self codeCollectionSlotName;
		collectionSlotModuleName: self moduleName;
		yourself
]

{ #category : #configuration }
LcsCodeClassesBuilderJob >> codeRootName: aRootName [
	self codeClassRootName: aRootName.
	self codeSlotName: (self codeSlotNameFrom: self codeClassRootName).
	self codeCollectionSlotName: self codeSlotName asEnglishPlural.
	self codeClassName: self classPrefix , aRootName.
	self codeCollectionClassName: self codeClassName asEnglishPlural
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeSlotName [
	^ codeSlotName
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeSlotName: aString [ 
	codeSlotName := aString
]

{ #category : #private }
LcsCodeClassesBuilderJob >> codeSlotNameFrom: aString [
	^ (aString at: 1) asLowercase asString , (aString copyFrom: 2 to: aString size)
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> domainClassCodeMemberSlotBuilder: eachClass [
	^ LcsMemberOfSlotBuilder new
		target: eachClass;
		collectionSlotName: self codeCollectionSlotName;
		slotName: self codeSlotName;
		moduleClass: self moduleClass;
		yourself
]

{ #category : #'slot model' }
LcsCodeClassesBuilderJob >> globalCollectionSlotDefinitionBuilder [
	^ (self jobSteps stepsWithClass: LcsGlobalSlotDefinitionBuilder) first
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> initialize [
	super initialize.
	self targetDomainClasses: OrderedCollection new
]

{ #category : #configuration }
LcsCodeClassesBuilderJob >> installMemberSlotInDomainClass: aClass [ 
	self targetDomainClasses add: aClass
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> module [
	^ self currentSystem moduleNamed: self moduleName
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> moduleClass [
	^ moduleClass
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> moduleClass: aModuleClass [ 
	moduleClass := aModuleClass
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> moduleName [
	^ self moduleClass moduleName
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> shortNameFrom: anArray [
	anArray size < 3 ifTrue: [ ^ self codeDescriptionFrom: anArray ].
	^ anArray at: 3
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> targetDomainClasses [
	^ targetDomainClasses
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> targetDomainClasses: aCollection [
	targetDomainClasses := aCollection
]

{ #category : #'slot model' }
LcsCodeClassesBuilderJob >> targetGlobalCollection [
	^ self module perform: self globalCollectionSlotDefinitionBuilder getterSelector
]

{ #category : #'slot model' }
LcsCodeClassesBuilderJob >> updateSlotModel [
	self jobSteps updateSlotModel.
	self currentSystem currentUnitOfWork applyChanges	
]

{ #category : #verification }
LcsCodeClassesBuilderJob >> verifyPopulateSlotModel [
	self subclassResponsibility
]

{ #category : #'slot model' }
LcsCodeClassesBuilderJob >> verifySlotModelUpdates [
	self jobSteps verifySlotModelUpdates
]
