Class {
	#name : #LcsGlobalSlotDefinitionBuilderTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'codeBuilder'
	],
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilderTest >> codeBuilder [
	^ codeBuilder
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilderTest >> codeBuilder: anObject [
	codeBuilder := anObject
]

{ #category : #running }
LcsGlobalSlotDefinitionBuilderTest >> tearDown [
	self codeBuilder ifNotNil: [ :builder | builder uninstall].
	super tearDown.
	self codeBuilder ifNotNil: [ :builder | builder verifyUninstall]
]

{ #category : #tests }
LcsGlobalSlotDefinitionBuilderTest >> testInstallingGlobalCollectionSlot [
	self codeBuilder: (
		LcsGlobalSlotDefinitionBuilder new
			slotClassName: LxxPersons name;
			slotName: 'foos';
			targetClassName: self currentSystem class name;
			targetModuleClass: self currentSystem class name;
			collectionElementTypes: { LxxPerson name };
			slotTypes: { LxxPersons name };
			yourself).
	self codeBuilder buildJobSteps.
	self codeBuilder installCode.
	self codeBuilder verifyCodeInstallation
]
