Class {
	#name : #LcsGlobalCollectionSlotTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'fooBuilder',
		'foosBuilder'
	],
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #subject }
LcsGlobalCollectionSlotTest class >> subjectClass [
	^ LcsGlobalCollectionSlot
]

{ #category : #private }
LcsGlobalCollectionSlotTest >> createFooClass [
	self fooBuilder: (
		LcsDomainClassBuilder new
			newClassName: 'Foo';
			targetPackageName: 'Lcs-Temp';
			yourself).
	fooBuilder fullyInstall
]

{ #category : #private }
LcsGlobalCollectionSlotTest >> createFoosClass [
	self foosBuilder: (
		LcsDomainCollectionClassBuilder new
			newClassName: 'Foos';
			targetPackageName: 'Lcs-Temp';
			yourself).
	self foosBuilder fullyInstall
]

{ #category : #accessing }
LcsGlobalCollectionSlotTest >> fooBuilder [
	^ fooBuilder
]

{ #category : #accessing }
LcsGlobalCollectionSlotTest >> fooBuilder: aBuilder [
	fooBuilder := aBuilder
]

{ #category : #private }
LcsGlobalCollectionSlotTest >> foosBuilder [
	^ foosBuilder
]

{ #category : #private }
LcsGlobalCollectionSlotTest >> foosBuilder: anObject [ 
	foosBuilder := anObject
]

{ #category : #private }
LcsGlobalCollectionSlotTest >> foosGlobalCollectionSlotBuilder [
	^ LcsGlobalSlotDefinitionBuilder new
		slotClassName: self fooBuilder newClassName;
		slotName: 'foos';
		targetClassName: LxxPrototypeSystem name;
		targetModuleClass: LxxPrototypeSystem moduleName;
		yourself
]

{ #category : #running }
LcsGlobalCollectionSlotTest >> setUp [
	self fooBuilder notNil ifTrue: [
		self should: [ self fooBuilder newClassName asClass ] raise: Error].
	self foosBuilder notNil ifTrue: [
		self should: [ self foosBuilder newClassName asClass ] raise: Error ].
	super setUp
]

{ #category : #running }
LcsGlobalCollectionSlotTest >> tearDown [
	self fooBuilder ifNotNil: [ self fooBuilder uninstall ].
	self foosBuilder ifNotNil: [ self foosBuilder uninstall ].
	super tearDown.
	self fooBuilder ifNotNil: [
		self should: [ self fooBuilder newClassName asClass ] raise: NotFound].
	self foosBuilder ifNotNil: [
		self should: [ self foosBuilder newClassName asClass ] raise: NotFound ]
]

{ #category : #test }
LcsGlobalCollectionSlotTest >> testCreation [
	self createNewSubject.
	self assert: self subject slotTypes isEmpty.
	self assert: self subject collectionMemberTypes isEmpty.
	self assert: self subject collectionClass isNil.
	self assert: self subject slotName isNil.
	self assert: self subject parent isNil.
	self assert: self subject required isNil.
	self assert: self subject initialValueBlock asString equals: '[ self slotTypes any new ]'.
	self assert: self subject validator isNil
]

{ #category : #test }
LcsGlobalCollectionSlotTest >> testInstallingAGlobalCollectionSlot [
	self createFooClass.
	self createFoosClass.
	self foosGlobalCollectionSlotBuilder
]
