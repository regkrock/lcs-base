Class {
	#name : #LcsCodeClassesBuilderJob,
	#superclass : #LcsDomainClassWithGlobalCollectionBuilderJob,
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
LcsCodeClassesBuilderJob >> codeCollectionClassBuilder [
	^ LcsCodeCollectionClassBuilder new
		newClassName: self globalCollectionClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> codesGlobalCollectionSlotBuilder [
	^ LcsCodesGlobalSlotDefinitionBuilder new
		slotClassName: self globalCollectionClassName;
		slotName: self globalCollectionSlotName;
		targetClassName: self globalCollectionModuleClass name;
		targetModuleClass: self globalCollectionModuleClass;
		loaderClassName: self globalCollectionClassName , 'Loader';
		yourself
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> codesLoaderBuilder [
	^ LcsCodesLoaderClassBuilder new
		newClassName: self globalCollectionClassName , 'Loader';
		instanceClassName: self newDomainClassName;
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
