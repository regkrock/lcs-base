Class {
	#name : #LcsSingletonCodeClassBuilderTest,
	#superclass : #LcsTestCase,
	#instVars : [
		'builder',
		'superclassBuilder'
	],
	#category : #'Lcs-Tests-Tests'
}

{ #category : #private }
LcsSingletonCodeClassBuilderTest >> createBuilder [
	self createFullyInstalledSuperclassBuilder.
	builder := LcsSingletonCodeClassBuilder new
			newClassName: self newClassName;
			targetSuperclassName: self superclassName;
			targetPackageName: 'Lcs-PrototypeSystem';
			rootName: 'Gender';
			yourself
]

{ #category : #private }
LcsSingletonCodeClassBuilderTest >> createFullyInstalledSuperclassBuilder [
	superclassBuilder := LcsCodeSuperClassBuilder new
			newClassName: self superclassName;
			targetPackageName: 'Lcs-PrototypeSystem';
			rootName: 'Gender'.
	superclassBuilder fullyInstall
]

{ #category : #private }
LcsSingletonCodeClassBuilderTest >> createInstalledBuilder [
	self createBuilder.
	builder installCode.
	builder verifyCodeInstallation.
	self shouldnt: [ self newClassName asClass ] raise: NotFound
]

{ #category : #private }
LcsSingletonCodeClassBuilderTest >> createPopulatedBuilder [
	self createUpdateSlotModelBuilder.
	builder populateSlotModel.
	builder verifyPopulateSlotModel.
]

{ #category : #private }
LcsSingletonCodeClassBuilderTest >> createUpdateSlotModelBuilder [
	self createInstalledBuilder.
	builder updateSlotModel.
	builder verifySlotModelUpdatesMadeByBuilder.
]

{ #category : #private }
LcsSingletonCodeClassBuilderTest >> newClassName [
	^ 'LxxMale1'
]

{ #category : #setUp }
LcsSingletonCodeClassBuilderTest >> setUp [
	super setUp.
	self should: [ self superclassName asClass ] raise: NotFound.
	self should: [ self newClassName asClass ] raise: NotFound
]

{ #category : #private }
LcsSingletonCodeClassBuilderTest >> superclassName [
	^ 'LxxGender1'
]

{ #category : #setUp }
LcsSingletonCodeClassBuilderTest >> tearDown [
	builder ifNotNil: [ builder uninstall ].
	superclassBuilder ifNotNil: [ superclassBuilder uninstall ].
	super tearDown.
	self should: [ self newClassName asClass ] raise: NotFound.
	self should: [ self superclassName asClass ] raise: NotFound
]

{ #category : #test }
LcsSingletonCodeClassBuilderTest >> testCreationStringForCreatingLxxGenderSubclassOfLcsCodesClass [
	self createBuilder.
	self assert: builder classCreationString equals: 'LxxGender1 subclass: #LxxMale1
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-PrototypeSystem'' '
	
]

{ #category : #test }
LcsSingletonCodeClassBuilderTest >> testInstallClass [
	self createBuilder.
	builder installCode.
	builder verifyCodeInstallation
]

{ #category : #test }
LcsSingletonCodeClassBuilderTest >> testPopulateSlotModelForClass [
	self createUpdateSlotModelBuilder.
	builder populateSlotModel.
	builder verifyPopulateSlotModel.
]

{ #category : #test }
LcsSingletonCodeClassBuilderTest >> testUninstallClass [
	self createPopulatedBuilder.
	builder uninstall.
	builder verifyUnistall
]

{ #category : #test }
LcsSingletonCodeClassBuilderTest >> testUpdateSlotModelForClass [
	self createInstalledBuilder.
	builder updateSlotModel.
	builder verifySlotModelUpdatesMadeByBuilder.
]
