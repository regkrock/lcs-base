"
The purpose of this class is test Global Colleciton Slot where it has not installed.
"
Class {
	#name : #LcsGlobalCollectionSlotTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'codeJobBuilder'
	],
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #accessing }
LcsGlobalCollectionSlotTest >> codeJobBuilder [
	^ codeJobBuilder
]

{ #category : #accessing }
LcsGlobalCollectionSlotTest >> codeJobBuilder: anObject [
	codeJobBuilder := anObject
]

{ #category : #running }
LcsGlobalCollectionSlotTest >> tearDown [
	self codeJobBuilder ifNotNil: [ :builder | builder uninstall].
	super tearDown.
	self codeJobBuilder ifNotNil: [ :builder | builder verifyUninstall]
]

{ #category : #tests }
LcsGlobalCollectionSlotTest >> testDefaultCreation [
	self subject: LcsGlobalCollectionSlot new.
	self assert: self subject slotTypes isEmpty.
	self assert: self subject collectionMemberTypes isEmpty.
	self assert: self subject collectionClass = IdentitySet.
	self assert: self subject slotName isNil.
	self assert: self subject parent isNil.
	self assert: self subject required isNil.
	self
		assert: self subject initialValueBlock asString
		equals: '[ :parentDomainObject | 
		(self slotTypes any new)
			parent: parentDomainObject;
			yourself ]'.
	self assert: (self subject validator isKindOf: LcsConditionsValidator)
]

{ #category : #tests }
LcsGlobalCollectionSlotTest >> testInstallingGlobalCollectionSlot [
	self codeJobBuilder: LcsCodeBuilderJob new.
	self codeJobBuilder addJobStep: (
		LcsGlobalSlotDefinitionBuilder new
			slotClassName: LxxPersons name;
			slotName: 'foos';
			targetClassName: self currentSystem class name;
			targetModuleClass: self currentSystem class name;
			collectionElementTypes: { LxxPerson name };
			yourself).
	self codeJobBuilder execute.
	self assert: (self currentSystem class hasSlotDefinitionNamed: 'foos')
]
