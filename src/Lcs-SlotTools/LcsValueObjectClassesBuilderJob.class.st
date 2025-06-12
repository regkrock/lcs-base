Class {
	#name : #LcsValueObjectClassesBuilderJob,
	#superclass : #LcsDomainClassAndDomainCollectionClassBuilderJob,
	#instVars : [
		'moduleClass',
		'protoCodes'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsValueObjectClassesBuilderJob >> addCodeSubclassWithRootNamed: aString with: aBlock [
	| classBuilder |
	classBuilder := self codeSubclassBuilderFor: aString.
	aBlock value: classBuilder.
	self codeSubclassBuilders add: classBuilder
]

{ #category : #builders }
LcsValueObjectClassesBuilderJob >> codeClassBuilder [
	^ LcsValueObjectSuperClassBuilder new
		newClassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #builders }
LcsValueObjectClassesBuilderJob >> codesCollectionClassBuilder [
	^ LcsCodesCollectionClassBuilder new
		newClassName: self collectionClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #builders }
LcsValueObjectClassesBuilderJob >> codesGlobalCollectionSlotBuilder [
	^ LcsValueObjectsGlobalCollectionSlotBuilder new
		slotName: self collectionSlotName;
		targetClassName: self collectionModuleClass name;
		targetModuleClass: self collectionModuleClass;
		loaderClassName: self collectionClassName , 'Loader';
		addCollectionElementType: self newDomainClassName;
		addSlotType: self collectionClassName;
		yourself
]

{ #category : #builders }
LcsValueObjectClassesBuilderJob >> codesLoaderBuilder [
	^ LcsValueObjectsLoaderClassBuilder new
		newClassName: self collectionClassName , 'Loader';
		instanceClassName: self newDomainClassName;
		unknownClassName: self unknownClassName;
		targetPackageName: self targetPackageName;
		protoCodes: self protoCodes;
		yourself
]

{ #category : #builders }
LcsValueObjectClassesBuilderJob >> domainClassCodeMemberSlotBuilder: aTargetClass [
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
LcsValueObjectClassesBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsGlobalCollectionSlotBuilder) first
]

{ #category : #initialize }
LcsValueObjectClassesBuilderJob >> initialize [
	super initialize.
	self targetDomainClasses: OrderedCollection new.
	self protoCodes: OrderedCollection new
]

{ #category : #accessing }
LcsValueObjectClassesBuilderJob >> protoCodes [
	^ protoCodes
]

{ #category : #accessing }
LcsValueObjectClassesBuilderJob >> protoCodes: aCollection [
	protoCodes := aCollection
]

{ #category : #'slot model' }
LcsValueObjectClassesBuilderJob >> targetGlobalCollection [
	^ self targetModule perform: self globalCollectionSlotDefinitionStep getterSelector
]

{ #category : #accessing }
LcsValueObjectClassesBuilderJob >> targetModuleName [
	^ targetModuleName ifNil: [ targetModuleName :=  self targetModuleClass defaultModuleName ]
]
