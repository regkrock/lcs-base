Class {
	#name : #LcsSlotDefinitionBuilderTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'codeBuilder'
	],
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #accessing }
LcsSlotDefinitionBuilderTest >> codeBuilder [
	^ codeBuilder
]

{ #category : #accessing }
LcsSlotDefinitionBuilderTest >> codeBuilder: anObject [
	codeBuilder := anObject
]

{ #category : #running }
LcsSlotDefinitionBuilderTest >> tearDown [
	self codeBuilder ifNotNil: [ :builder | builder uninstall].
	super tearDown.
	self codeBuilder ifNotNil: [ :builder | builder verifyUninstall]
]

{ #category : #tests }
LcsSlotDefinitionBuilderTest >> testInstallingSlot [
	self codeBuilder: (
		LcsSlotDefinitionBuilder new
			slotName: 'foos';
			slotDefinitionClassName: LcsStringSlot name;
			targetClassName: self currentSystem class name;
			addSlotType: LxxPerson name ;
			yourself).
	self codeBuilder buildJobSteps.
	self codeBuilder installCode.
	self codeBuilder verifyCodeInstallation
]
