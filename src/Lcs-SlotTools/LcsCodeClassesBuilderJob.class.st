Class {
	#name : #LcsCodeClassesBuilderJob,
	#superclass : #LcsDomainClassAndDomainCollectionClassBuilderJob,
	#instVars : [
		'moduleClass',
		'protoCodes'
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
LcsCodeClassesBuilderJob >> codesCollectionClassBuilder [
	^ LcsCodesCollectionClassBuilder new
		newClassName: self collectionClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> codesGlobalCollectionSlotBuilder [
	^ LcsCodesGlobalSlotDefinitionBuilder new
		slotClassName: self collectionClassName;
		slotName: self collectionSlotName;
		targetClassName: self collectionModuleClass name;
		targetModuleClass: self collectionModuleClass;
		loaderClassName: self collectionClassName , 'Loader';
		addCollectionElementType: self newDomainClassName;
		addSlotType: self collectionClassName;
		yourself
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> codesLoaderBuilder [
	^ LcsCodesLoaderClassBuilder new
		newClassName: self collectionClassName , 'Loader';
		instanceClassName: self newDomainClassName;
		unknownClassName: self unknownClassName;
		targetPackageName: self targetPackageName;
		protoCodes: self protoCodes;
		yourself
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> domainClassCodeMemberSlotBuilder: aTargetClass [
	^ LcsMemberOfSlotBuilder new
		target: aTargetClass;
		targetClassName: aTargetClass name;
		slotName: self domainInstanceSlotName;
		collectionSlotName: self collectionSlotName;
		targetModuleClass: self collectionModuleClass;
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
	self targetDomainClasses: OrderedCollection new.
	self protoCodes: OrderedCollection new
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> protoCodes [
	^ protoCodes
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> protoCodes: aCollection [
	protoCodes := aCollection
]

{ #category : #'slot model' }
LcsCodeClassesBuilderJob >> targetGlobalCollection [
	^ self targetModule perform: self globalCollectionSlotDefinitionStep getterSelector
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> targetModuleName [
	^ targetModuleName ifNil: [ targetModuleName :=  self targetModuleClass defaultModuleName ]
]
