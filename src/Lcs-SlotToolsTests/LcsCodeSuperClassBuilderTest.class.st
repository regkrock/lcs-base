Class {
	#name : #LcsCodeSuperClassBuilderTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'builder'
	],
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #accessing }
LcsCodeSuperClassBuilderTest >> builder [
	^ builder
]

{ #category : #accessing }
LcsCodeSuperClassBuilderTest >> builder: anObject [
	builder := anObject
]

{ #category : #private }
LcsCodeSuperClassBuilderTest >> createBuilder [
	builder := LcsCodeSuperClassBuilder new
			newClassName: self newClassName;
			targetPackageName: 'Lcs-Temp';
			rootName: 'Gender'
]

{ #category : #private }
LcsCodeSuperClassBuilderTest >> createInstalledBuilder [
	self createBuilder.
	builder installCode.
	builder verifyCodeInstallation.
	self shouldnt: [ self newClassName asClass ] raise: NotFound
]

{ #category : #private }
LcsCodeSuperClassBuilderTest >> createPopulatedBuilder [
	self createUpdateSlotModelBuilder.
	builder populateSlotModel.
	builder verifyPopulateSlotModel.
]

{ #category : #private }
LcsCodeSuperClassBuilderTest >> createUpdateSlotModelBuilder [
	self createInstalledBuilder.
	builder updateSlotModel.
	builder verifySlotModelUpdatesMadeByBuilder.
]

{ #category : #private }
LcsCodeSuperClassBuilderTest >> newClassName [
	^ 'LxxGender1'
]

{ #category : #setUp }
LcsCodeSuperClassBuilderTest >> setUp [
	super setUp.
	self should: [ self newClassName asClass ] raise: NotFound
]

{ #category : #setUp }
LcsCodeSuperClassBuilderTest >> tearDown [
	self builder ifNotNil: [ builder uninstall ].
	super tearDown.
	self should: [ self newClassName asClass ] raise: NotFound
]

{ #category : #test }
LcsCodeSuperClassBuilderTest >> testCreationStringForCreatingLxxGenderSubclassOfLcsCodesClass [
	| builder |
	builder := LcsCodeSuperClassBuilder new.
	builder 
		newClassName: 'LxxGender1';
		targetPackageName: 'Lcs-PrototypeSystem';
		rootName: 'Gender1'.
	self assert: builder classCreationString equals: 'LcsCode subclass: #LxxGender1
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-PrototypeSystem'' '
	
]

{ #category : #test }
LcsCodeSuperClassBuilderTest >> testInstallClass [
	self createBuilder.
	builder installCode.
	builder verifyCodeInstallation
]

{ #category : #test }
LcsCodeSuperClassBuilderTest >> testPopulateSlotModelForClass [
	self createUpdateSlotModelBuilder.
	builder populateSlotModel.
	builder verifyPopulateSlotModel.
]

{ #category : #test }
LcsCodeSuperClassBuilderTest >> testUninstallClass [
	self createPopulatedBuilder.
	builder uninstall.
	builder verifyUnistall
]

{ #category : #test }
LcsCodeSuperClassBuilderTest >> testUpdateSlotModelForClass [
	self createInstalledBuilder.
	builder updateSlotModel.
	builder verifySlotModelUpdatesMadeByBuilder.
]
