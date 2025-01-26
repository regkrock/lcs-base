"
The purpose of this class is test an installed Global Colleciton Slot.

The slot is created during the setUp step.

It will be removed in the tearDown.
"
Class {
	#name : #LcsInstalledGlobalCollectionSlotTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'codeJobBuilder'
	],
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #subject }
LcsInstalledGlobalCollectionSlotTest class >> subjectClass [
	^ LcsGlobalCollectionSlot
]

{ #category : #accessing }
LcsInstalledGlobalCollectionSlotTest >> codeJobBuilder [
	^ codeJobBuilder
]

{ #category : #accessing }
LcsInstalledGlobalCollectionSlotTest >> codeJobBuilder: anObject [
	codeJobBuilder := anObject
]

{ #category : #initialize }
LcsInstalledGlobalCollectionSlotTest >> newCodeJobBuilder [
	^ LcsGlobalDomainClassClassesBuilderJob new
		classPrefix: 'Lxx';
		installNewClassesInPackageNamed: 'Lcs-Temp';
		createForRootName: 'Foo';
		installGlobalCollectionSlotInModuleClass: LxxPrototypeSystem;
		installMemberSlotInDomainClass: LxxPrototypePerson;
		buildJobSteps
]

{ #category : #running }
LcsInstalledGlobalCollectionSlotTest >> setUp [
	self codeJobBuilder: self newCodeJobBuilder.
	super setUp
]

{ #category : #running }
LcsInstalledGlobalCollectionSlotTest >> tearDown [
	self codeJobBuilder uninstall.
	super tearDown.
	self codeJobBuilder verifyUninstall
]

{ #category : #tests }
LcsInstalledGlobalCollectionSlotTest >> testInstallingGlobalCollectionSlot [
	self codeJobBuilder execute.
	self assert: (self currentSystem class hasSlotDefinitionNamed: 'foos')
]
