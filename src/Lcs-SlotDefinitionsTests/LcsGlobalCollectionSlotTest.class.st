Class {
	#name : #LcsGlobalCollectionSlotTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'fooBuilder',
		'foosBuilder',
		'builders'
	],
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #subject }
LcsGlobalCollectionSlotTest class >> subjectClass [
	^ LcsGlobalCollectionSlot
]

{ #category : #accessing }
LcsGlobalCollectionSlotTest >> builders [
	^ builders
]

{ #category : #accessing }
LcsGlobalCollectionSlotTest >> builders: anObject [
	builders := anObject
]

{ #category : #private }
LcsGlobalCollectionSlotTest >> createFooClass [
	self fooBuilder: LxxFooClassExampleBuilder new fullyInstall
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

{ #category : #initialize }
LcsGlobalCollectionSlotTest >> initialize [
	super initialize.
	self builders: OrderedCollection new.
	self builders add: LxxFooClassExampleBuilder new.
	self builders add: LxxFooClassExampleBuilder new
]

{ #category : #running }
LcsGlobalCollectionSlotTest >> setUp [
	self builders do: [ :each | each assertNotInstalled ].
	super setUp
]

{ #category : #running }
LcsGlobalCollectionSlotTest >> tearDown [
	self builders do: [ :each | each tearDown ].
	super tearDown.
	self builders do: [ :each | each assertNotInstalled ]
]

{ #category : #tests }
LcsGlobalCollectionSlotTest >> testDefaultCreation [
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

{ #category : #tests }
LcsGlobalCollectionSlotTest >> testInstallingGlobalCollectionSlot [
	self builders 
		add: LxxFooClassExampleBuilder new;
		add: LxxFoosClassExampleBuilder new;
		add: self foosGlobalCollectionSlotBuilder.
	self builders do: [ :each | each install ].
	self builders do: [ :each | each ].
]
