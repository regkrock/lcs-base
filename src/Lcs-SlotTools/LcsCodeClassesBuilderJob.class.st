Class {
	#name : #LcsCodeClassesBuilderJob,
	#superclass : #LcsDomainClassWithGlobalCollectionBuilderJob,
	#instVars : [
		'moduleClass'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsCodeClassesBuilderJob >> addCodeSubclassWithRootNamed: aString with: aBlock [
	| classBuilder |
	classBuilder := self codeSubclassBuilderFor: aString.
	aBlock value: classBuilder.
	self codeSubclassBuilders add: classBuilder
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> codeClassBuilder [
	^ LcsCodeSuperClassBuilder new
		newClassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> codeCollectionClassBuilder [
	^ LcsCodeCollectionClassBuilder new
		newClassName: self globalCollectionClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #private }
LcsCodeClassesBuilderJob >> codeDescriptionFrom: anArray [
	anArray size < 2 ifTrue: [ ^ (anArray at: 1) capitalized ].
	^ anArray at: 2
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> codeGlobalCollectionSlotBuilder [
	^ LcsGlobalSlotDefinitionBuilder new
		slotClassName: self globalCollectionClassName;
		slotName: self globalCollectionSlotName;
		targetClassName: self globalCollectionModuleClass name;
		targetModuleClass: self globalCollectionModuleClass;
		yourself
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> domainClassCodeMemberSlotBuilder: aTargetClass [
	^ LcsMemberOfSlotBuilder new
		target: aTargetClass;
		targetClassName: aTargetClass name;
		slotName: self domainInstanceSlotName;
		collectionSlotName: self globalCollectionSlotName;
		targetModuleClass: self globalCollectionModuleClass;
		addSlotType: self newDomainClassName;
		yourself
]

{ #category : #'builder step' }
LcsCodeClassesBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsGlobalSlotDefinitionBuilder) first
]

{ #category : #initialize }
LcsCodeClassesBuilderJob >> initialize [
	super initialize.
	self targetDomainClasses: OrderedCollection new
]

{ #category : #private }
LcsCodeClassesBuilderJob >> shortNameFrom: anArray [
	anArray size < 3 ifTrue: [ ^ self codeDescriptionFrom: anArray ].
	^ anArray at: 3
]

{ #category : #'slot model' }
LcsCodeClassesBuilderJob >> targetGlobalCollection [
	^ self targetModule perform: self globalCollectionSlotDefinitionStep getterSelector
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> targetModuleName [
	^ targetModuleName ifNil: [ targetModuleName :=  self targetModuleClass moduleName ]
]
