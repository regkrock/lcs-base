Class {
	#name : #LcsMemberOfSlotBuilderTest,
	#superclass : #LcsSlotDefinitionBuilderTest,
	#instVars : [
		'slotName',
		'targetClass'
	],
	#category : #'Lcs-PrototypeSystemTests'
}

{ #category : #private }
LcsMemberOfSlotBuilderTest >> newBuilder [
	self slotName: 'person'.
	self targetClass: LxxPrototype2Submodule.
	^ LcsMemberOfSlotBuilder new
		targetClass: self targetClass;
		slotName: self slotName;
		collectionSlotName: 'persons';
		collectionSlotModuleName: LxxPrototypePersonsModule moduleName;
		addSlotType: LxxPrototypePerson;
		yourself
]

{ #category : #running }
LcsMemberOfSlotBuilderTest >> removeArtifactsRelatedToSlot [
	self slotName
		ifNotNil: [ 
			self targetClass removeDomainSlotNamed: self slotName.
			self targetClass assertDomainSlotRemoved: self slotName ]
]

{ #category : #running }
LcsMemberOfSlotBuilderTest >> setupSunitSystem [
	LxxPrototypeSystem new
]

{ #category : #accessing }
LcsMemberOfSlotBuilderTest >> slotName [
	^ slotName
]

{ #category : #acccessing }
LcsMemberOfSlotBuilderTest >> slotName: aString [
	slotName := aString
]

{ #category : #accessing }
LcsMemberOfSlotBuilderTest >> targetClass [
	^ targetClass
]

{ #category : #accessing }
LcsMemberOfSlotBuilderTest >> targetClass: anObject [
	targetClass := anObject
]

{ #category : #running }
LcsMemberOfSlotBuilderTest >> tearDown [
	self removeArtifactsRelatedToSlot.
	super tearDown
]

{ #category : #tests }
LcsMemberOfSlotBuilderTest >> testBuilderSetup [
	| builder |
	builder := self newBuilder.
	self assert: builder target identicalTo: self targetClass.
	self assert: builder targetClass identicalTo: self targetClass.
	self assert: builder slotName equals: self slotName.
	self assert: builder collectionSlotName equals: 'persons'.
	self
		assert: builder collectionSlotModuleName
		equals: LxxPrototypePersonsModule moduleName.
	self assert: builder slotTypes notEmpty.
	self
		assert: builder slotDefinitionSource
		equals: 'personSlotDefinition
	<slotDefinition>
	^ LcsMemberOfSlot new
		slotName: ''person'';
		addSlotType: LxxPrototypePerson;
		collectionSlotName: ''persons'';
		collectionModuleName: ''Persons Module'';
		yourself'
]

{ #category : #tests }
LcsMemberOfSlotBuilderTest >> testCreation [
	| builder |
	builder := LcsMemberOfSlotBuilder new.
	self should: builder target isNil.
	self should: builder targetClass isNil.
	self assert: builder targetClassName equals: '<missing target class>'.
	self assert: builder slotName isNil.
	self assert: builder collectionSlotName isNil.
	self assert: builder collectionSlotModuleName isNil.
	self assert: builder slotTypes isEmpty.
	self assert: builder slotDefinitionSource equals: 'undefinedSlotDefinition
	<slotDefinition>
	^ LcsMemberOfSlot new
		slotName: ''<missing>'';
		addSlotType: ''<no slot types defined>'';
		collectionSlotName: ''<missing>'';
		collectionModuleName: ''<missing>'';
		yourself' 
]

{ #category : #tests }
LcsMemberOfSlotBuilderTest >> testInstallation [
	| builder |
	builder := self newBuilder.

	self should: [ LxxPrototype2Submodule slotDefinitionNamed: self slotName] raise: Error.
	self deny: (LxxPrototype2Submodule allInstVarNames includes: self slotName). 
	
	builder fullyInstall.
	
	self assert: (LxxPrototype2Submodule slotDefinitionNamed: self slotName) slotName equals: slotName.
	self assert: (LxxPrototype2Submodule allInstVarNames includes: self slotName). 
	self assert: (LxxPrototype2Submodule canUnderstand: self slotName asSymbol).
	self assert: (LxxPrototype2Submodule canUnderstand: (self slotName , ':') asSymbol).
	self assert: (LxxPrototype2Submodule class canUnderstand: (self slotName , 'SlotDefinition') asSymbol).
	self assert: ((LxxPrototype2Submodule slotDefinitionNamed: self slotName) slotTypes includes: LxxPrototypePerson).
]
