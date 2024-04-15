Class {
	#name : #LcsGlobalSlotDefinitionBuilderTest,
	#superclass : #LcsDomainTestCase,
	#category : #'Lcs-BarebonesSystemTests'
}

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilderTest >> createLxxUserClass [
	([ 'LxxUser'asClass ] on: NotFound do: [  nil ]) ifNil: [
		(RBAddClassRefactoring
			addClass: 'LxxUser' asSymbol
			superclass: LcsDomainObject
			subclasses: #()
			category: #'Lcs-BarebonesSystem') execute ]
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilderTest >> createLxxUsersClass [
	([ 'LxxUsers'asClass ] on: NotFound do: [  nil ]) ifNil: [
		(RBAddClassRefactoring
			addClass: 'LxxUsers' asSymbol
			superclass: LcsDomainCollection
			subclasses: #()
			category: #'Lcs-BarebonesSystem') execute ]
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilderTest >> removeClassName: aString [
	[ aString asClass ] on: NotFound do: [ ^ self ].
	(RBRemoveClassRefactoring
		classNames: {aString}) execute
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilderTest >> removeLxxUserClass [
	self removeClassName: 'LxxUser'
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilderTest >> removeLxxUsersClass [
	self removeClassName: 'LxxUsers'
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilderTest >> setupSunitSystem [
	LxxBarebonesSystem new
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilderTest >> tearDown [
	super tearDown.

	LxxBarebonesSystem removeSlotNamed: 'users'.
"	self removeLxxUserClass.
	self removeLxxUsersClass."

	LxxBarebonesSystem assertSlotRemoved: 'users'.
	
	"self deny: ([ 'LxxUser' asClass ] on: NotFound do: [ true ]).
	self deny: ([ 'LxxUsers' asClass ] on: NotFound do: [ true ])."


]

{ #category : #tests }
LcsGlobalSlotDefinitionBuilderTest >> testInstallingUsersGlobalCollection [
	| builder |

	"self removeLxxUserClass.
	self removeLxxUsersClass."
	
	self createLxxUserClass.
	self createLxxUsersClass.

	LxxBarebonesSystem assertSlotRemoved: 'users'.

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
