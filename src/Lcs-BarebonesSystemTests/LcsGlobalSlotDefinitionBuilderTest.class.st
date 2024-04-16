Class {
	#name : #LcsGlobalSlotDefinitionBuilderTest,
	#superclass : #LcsDomainTestCase,
	#category : #'Lcs-BarebonesSystemTests'
}

{ #category : #running }
LcsGlobalSlotDefinitionBuilderTest >> createLxxUserClass [
	self
		createClassName: 'LxxUser'
		superclassName: 'LcsDomainCollection'
		category: #'Lcs-BarebonesSystem'
]

{ #category : #running }
LcsGlobalSlotDefinitionBuilderTest >> createLxxUsersClass [
	self
		createClassName: 'LxxUsers'
		superclassName: 'LcsDomainCollection'
		category: #'Lcs-BarebonesSystem'
]

{ #category : #running }
LcsGlobalSlotDefinitionBuilderTest >> removeArtifactsRelatedToUsersSlot [
	LxxBarebonesSystem removeDomainSlotNamed: 'users'.
	self removeLxxUserClass.
	self removeLxxUsersClass.

	LxxBarebonesSystem assertSlotRemoved: 'users'.
	self assert: (self classNamed: 'LxxUsers') isNil.
	self assert: (self classNamed: 'LxxUser') isNil
]

{ #category : #setUp }
LcsGlobalSlotDefinitionBuilderTest >> removeLxxUserClass [
	self removeClassName: 'LxxUser'
]

{ #category : #running }
LcsGlobalSlotDefinitionBuilderTest >> removeLxxUsersClass [
	self removeClassName: 'LxxUsers'
]

{ #category : #running }
LcsGlobalSlotDefinitionBuilderTest >> setupSunitSystem [
	LxxBarebonesSystem new
]

{ #category : #running }
LcsGlobalSlotDefinitionBuilderTest >> tearDown [
	super tearDown.
	self removeArtifactsRelatedToUsersSlot
]

{ #category : #tests }
LcsGlobalSlotDefinitionBuilderTest >> testInstallingUsersGlobalCollection [
	| builder |

	self removeArtifactsRelatedToUsersSlot.
	
	self createLxxUserClass.
	self createLxxUsersClass.


	builder := LcsGlobalSlotDefinitionBuilder new
				slotName: 'users';
				moduleName: LxxBarebonesSystem moduleName;
				slotClass: 'LxxUsers' asClass;
				collectionSlotCollectionClass: LcsSmalltalkConfiguration identitySetClass;
				collectionElementTypes: { 'LxxUser' asClass. };
				yourself.
		
	self assert: builder slotName equals: 'users'.
	self assert: builder targetClassName equals: 'LxxBarebonesSystem'.
	self assert: builder target equals: LxxBarebonesSystem.
	self assert: builder slotDefinitionSelector equals: 'usersSlotDefinition'.	
	
	builder install.
	
	LxxBarebonesSystem assertSlotAdded: 'users'.

]
