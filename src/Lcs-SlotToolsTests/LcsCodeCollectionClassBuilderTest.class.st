Class {
	#name : #LcsCodeCollectionClassBuilderTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'builder'
	],
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #test }
LcsCodeCollectionClassBuilderTest >> createBuilder [
	builder := LcsCodeCollectionClassBuilder new
			newClassName: self newClassName;
			targetPackageName: 'Lcs-Temp';
			rootName: 'Foos'
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
	builder verifySlotModelUpdatesMadeByBuilder.
]

{ #category : #private }
LcsCodeCollectionClassBuilderTest >> newClassName [
	^ 'LxxFoos'
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
LcsCodeCollectionClassBuilderTest >> testCreationStringForCreatingLxxFoosSubclassOfLcsCodes [
	self createBuilder.
	self
		assert: builder classCreationString
		equals: 'LcsCodes subclass: #LxxFoos
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '
]

{ #category : #test }
LcsCodeCollectionClassBuilderTest >> testInstallClass [
	self createBuilder.
	builder installCode.
	builder verifyCodeInstallation
]

{ #category : #test }
LcsCodeCollectionClassBuilderTest >> testPopulateSlotModelForClass [
	self createUpdateSlotModelBuilder.
	builder populateSlotModel.
	builder verifyPopulateSlotModel.
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
	builder verifySlotModelUpdatesMadeByBuilder.
]
