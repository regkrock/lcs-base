Class {
	#name : 'LcsValueObjectClassesBuilderJob',
	#superclass : 'LcsDomainClassAndDomainCollectionClassBuilderJob',
	#instVars : [
		'moduleClass',
		'protoCodes'
	],
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'configuration' }
LcsValueObjectClassesBuilderJob >> addValueObjectSubclassWithRootNamed: aString with: aBlock [
	| classBuilder |
	classBuilder := self valueObjectSubclassBuilderFor: aString.
	aBlock value: classBuilder.
	self valueObjectSubclassBuilders add: classBuilder
]

{ #category : 'builders' }
LcsValueObjectClassesBuilderJob >> domainClassCodeMemberSlotBuilder: aTargetClass [
	^ LcsMemberOfGlobalCollectionSlotBuilder new
		target: aTargetClass;
		targetClassName: aTargetClass name;
		slotName: self domainInstanceSlotName;
		collectionSlotName: self collectionSlotName;
		targetModuleClass: self collectionModuleClass;
		addSlotType: self newDomainClassName;
		yourself
]

{ #category : 'builder step' }
LcsValueObjectClassesBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsGlobalCollectionSlotBuilder) first
]

{ #category : 'initialize' }
LcsValueObjectClassesBuilderJob >> initialize [
	super initialize.
	self targetDomainClasses: OrderedCollection new.
	self protoCodes: OrderedCollection new
]

{ #category : 'accessing' }
LcsValueObjectClassesBuilderJob >> protoCodes [
	^ protoCodes
]

{ #category : 'accessing' }
LcsValueObjectClassesBuilderJob >> protoCodes: aCollection [
	protoCodes := aCollection
]

{ #category : 'slot model' }
LcsValueObjectClassesBuilderJob >> targetGlobalCollection [
	^ self targetModule perform: self globalCollectionSlotDefinitionStep getterSelector
]

{ #category : 'accessing' }
LcsValueObjectClassesBuilderJob >> targetModuleName [
	^ targetModuleName ifNil: [ targetModuleName :=  self targetModuleClass defaultModuleName ]
]

{ #category : 'builders' }
LcsValueObjectClassesBuilderJob >> valueObjectClassBuilder [
	^ LcsValueObjectSuperClassBuilder new
		newClassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : 'builders' }
LcsValueObjectClassesBuilderJob >> valueObjectsCollectionClassBuilder [
	^ LcsValueObjectsCollectionClassBuilder new
		newClassName: self collectionClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : 'builders' }
LcsValueObjectClassesBuilderJob >> valueObjectsGlobalCollectionSlotBuilder [
	^ LcsValueObjectsGlobalCollectionSlotBuilder new
		slotName: self collectionSlotName;
		targetClassName: self collectionModuleClass name;
		targetModuleClass: self collectionModuleClass;
		loaderClassName: self collectionClassName , 'Loader';
		addCollectionMemberType: self newDomainClassName;
		addSlotType: self collectionClassName;
		yourself
]

{ #category : 'builders' }
LcsValueObjectClassesBuilderJob >> valueObjectsLoaderBuilder [
	| builder |
	builder := LcsValueObjectsLoaderClassBuilder new
			newClassName: self collectionClassName , 'Loader';
			instanceClassName: self newDomainClassName;
			targetPackageName: self targetPackageName;
			protoCodes: self protoCodes.
	self buildUnknownClass ifTrue: [
			builder unknownClassName: self unknownClassName].
	^ builder
]
