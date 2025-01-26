Class {
	#name : #LcsGlobalCollectionSlotTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'codeJobBuilder'
	],
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #subject }
LcsGlobalCollectionSlotTest class >> subjectClass [
	^ LcsGlobalCollectionSlot
]

{ #category : #accessing }
LcsGlobalCollectionSlotTest >> codeJobBuilder [
	^ codeJobBuilder
]

{ #category : #accessing }
LcsGlobalCollectionSlotTest >> codeJobBuilder: anObject [
	codeJobBuilder := anObject
]

{ #category : #initialize }
LcsGlobalCollectionSlotTest >> initialize [
	super initialize.
	self codeJobBuilder: self newCodeJobBuilder
]

{ #category : #initialize }
LcsGlobalCollectionSlotTest >> newCodeJobBuilder [
	"^ LcsCodeBuilderJob new  <--- If this abstracted, then this will be superclass implementation"
	^ LcsGlobalDomainClassClassesBuilderJob new
		classPrefix: 'Lxx';
		installNewClassesInPackageNamed: 'Lcs-Temp';
		createForRootName: 'Foo';
		installGlobalCollectionSlotInModuleClass: LxxPrototypeSystem;
		installMemberSlotInDomainClass: LxxPrototypePerson;
		buildJobSteps
]

{ #category : #running }
LcsGlobalCollectionSlotTest >> setUp [
	"self codeJobBuilder assertNotInstalled."
	super setUp
]

{ #category : #running }
LcsGlobalCollectionSlotTest >> tearDown [
	self codeJobBuilder uninstall.
	super tearDown.
	self codeJobBuilder verifyUninstall
]

{ #category : #tests }
LcsGlobalCollectionSlotTest >> testDefaultCreation [
	self useEmptyCodeJobBuilder.
	self createNewSubject.
	self assert: self subject slotTypes isEmpty.
	self assert: self subject collectionMemberTypes isEmpty.
	self assert: self subject collectionClass isNil.
	self assert: self subject slotName isNil.
	self assert: self subject parent isNil.
	self assert: self subject required isNil.
	self
		assert: self subject initialValueBlock asString
		equals: '[ self slotTypes any new ]'.
	self assert: self subject validator isNil
]

{ #category : #tests }
LcsGlobalCollectionSlotTest >> testInstallingGlobalCollectionSlot [
	self codeJobBuilder execute.
	self assert: (self currentSystem class hasSlotDefinitionNamed: 'foos')
]

{ #category : #private }
LcsGlobalCollectionSlotTest >> useEmptyCodeJobBuilder [
	self codeJobBuilder: LcsCodeBuilderJob new
]
