Class {
	#name : #LcsCodeCollectionClassBuilderTest,
	#superclass : #LcsTestCase,
	#instVars : [
		'builder'
	],
	#category : #'Lcs-Tests-Tests'
}

{ #category : #test }
LcsCodeCollectionClassBuilderTest >> createBuilder [
	builder := LcsCodeCollectionClassBuilder new
			newClassName: 'LxxGenders1';
			targetPackageName: 'Lcs-PrototypeSystem';
			rootName: 'Genders1'
]

{ #category : #private }
LcsCodeCollectionClassBuilderTest >> createInstalledBuilder [
	self createBuilder.
	builder installCode.
	builder verifyCodeInstallation.
	self shouldnt: [ self newClassName asClass ] raise: NotFound
]

{ #category : #private }
LcsCodeCollectionClassBuilderTest >> createPopulatedBuilder [
	self createUpdateSlotModelBuilder.
	builder populateSlotModel.
	builder verifyPopulateSlotModel.
]

{ #category : #private }
LcsCodeCollectionClassBuilderTest >> createUpdateSlotModelBuilder [
	self createInstalledBuilder.
	builder updateSlotModel.
	builder verifySlotModelUpdates.
]

{ #category : #private }
LcsCodeCollectionClassBuilderTest >> newClassName [
	^ 'LxxGenders1'
]

{ #category : #setUp }
LcsCodeCollectionClassBuilderTest >> setUp [
	super setUp.
	self should: [ self newClassName asClass ] raise: NotFound
]

{ #category : #setUp }
LcsCodeCollectionClassBuilderTest >> tearDown [
	builder ifNotNil: [ builder uninstall ].
	super tearDown.
	self should: [ self newClassName asClass ] raise: NotFound
]

{ #category : #test }
LcsCodeCollectionClassBuilderTest >> testCreationStringForCreatingLxxGendersSubclassOfLcsCodes [
	self createBuilder.
	self
		assert: builder classCreationString
		equals: 'LcsCodes subclass: #LxxGenders1
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-PrototypeSystem'' '
]

{ #category : #test }
LcsCodeCollectionClassBuilderTest >> testInstallClass [
	self createBuilder.
	builder installCode.
	builder verifyCodeInstallation
]

{ #category : #test }
LcsCodeCollectionClassBuilderTest >> testUninstallClass [
	self createPopulatedBuilder.
	builder uninstall.
	builder verifyUnistall
]

{ #category : #testing }
LcsCodeCollectionClassBuilderTest >> testUpdateSlotModelForClass [
	self createInstalledBuilder.
	builder updateSlotModel.
	builder verifySlotModelUpdates.
]
