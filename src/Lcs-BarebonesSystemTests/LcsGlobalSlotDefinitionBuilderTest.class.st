Class {
	#name : #LcsGlobalSlotDefinitionBuilderTest,
	#superclass : #LcsDomainTest,
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

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilderTest >> gendersBuilder [
	^ LcsSingletonCodeClassesBuilderJob new
		classPrefix: 'Lxx';
		installNewClassesInPackageNamed: 'Lcs-BarebonesSystem';
		codeRootName: 'Gender';
		addCodeSubclassWithRootNamed: 'Male';
		addCodeSubclassWithRootNamed: 'Female';
		addCodeSubclassWithRootNamed: 'UnknownGender'
			with: [ :classBuilder | classBuilder beDefaultInstance ];
		moduleClass: LxxBarebonesSystem;
		installMemberSlotInDomainClass: LxxBarebonesPerson;
		yourself
]

{ #category : #running }
LcsGlobalSlotDefinitionBuilderTest >> removeArtifactsRelatedToGendersSlot [
	LxxBarebonesPerson removeDomainSlotNamed: 'gender'.
	LxxBarebonesSystem removeDomainSlotNamed: 'genders'.
	LxxBarebonesSystem removeDomainSlotNamed: 'genders1'.
	self removeClassesNamed: #('LxxGender' 'LxxGenders' 'LxxMale' 'LxxFemale' 'LxxUnknownGender').
]

{ #category : #running }
LcsGlobalSlotDefinitionBuilderTest >> removeArtifactsRelatedToUsersSlot [
	LxxBarebonesSystem removeDomainSlotNamed: 'users'.
	self removeClassesNamed: #('LxxUser' 'LxxUsers').

	LxxBarebonesSystem assertSlotRemoved: 'users'.
	self assert: (self classNamed: 'LxxUsers') isNil.
	self assert: (self classNamed: 'LxxUser') isNil
]

{ #category : #running }
LcsGlobalSlotDefinitionBuilderTest >> setupSunitSystem [
	LxxBarebonesSystem new
]

{ #category : #running }
LcsGlobalSlotDefinitionBuilderTest >> tearDown [
	self removeArtifactsRelatedToUsersSlot.
	self removeArtifactsRelatedToGendersSlot.
	super tearDown
]

{ #category : #tests }
LcsGlobalSlotDefinitionBuilderTest >> testInstallingUsersGlobalCollection [
	| builder |
	self removeArtifactsRelatedToUsersSlot.

	self createLxxUserClass.
	self createLxxUsersClass.

	builder := self usersGlobalCollectionBuilder.

	self assert: builder slotName equals: 'users'.
	self assert: builder targetClassName equals: 'LxxBarebonesSystem'.
	self assert: builder target equals: LxxBarebonesSystem.
	self assert: builder slotDefinitionSelector equals: 'usersSlotDefinition'.

	builder install.

	LxxBarebonesSystem verifyClassHasDomainSlotNamed: 'users'
]

{ #category : #tests }
LcsGlobalSlotDefinitionBuilderTest >> testInstallingUsersGlobalCollectionWithExistingGetterAndSetterForGenderWhichAreNotSetUpForSlots [
	| builder |

	self removeArtifactsRelatedToUsersSlot.
	self removeArtifactsRelatedToGendersSlot.

	builder := self gendersBuilder.
	builder install.
	
	self assert: (LxxBarebonesSystem canUnderstand: #genders).
	self assert: (LxxBarebonesSystem canUnderstand: #genders:).
	
	LxxBarebonesSystem compile: 'genders
	^ genders'.
	LxxBarebonesSystem compile: 'genders: anObject
	genders := anObject'.

	"Attempt to create genders getter and selector again where the existing gender and genders methods do something different"

	(RBCreateDomainSlotAcccessorsForVariableRefactoring
		instanceVariable: 'genders'
		class: LxxBarebonesSystem) execute.

	self assert: (LxxBarebonesSystem canUnderstand: #genders).
	self assert: (LxxBarebonesSystem canUnderstand: #genders:).
	self assert: (LxxBarebonesSystem canUnderstand: #genders1).
	self assert: (LxxBarebonesSystem canUnderstand: #genders1:)
]

{ #category : #tests }
LcsGlobalSlotDefinitionBuilderTest >> testInstallingUsersGlobalCollectionWithExistingGetterAndSetterForGenders [
	| builder |

	self removeArtifactsRelatedToUsersSlot.
	self removeArtifactsRelatedToGendersSlot.

	builder := self gendersBuilder.
	builder install.
	
	self assert: (LxxBarebonesSystem canUnderstand: #genders).
	self assert: (LxxBarebonesSystem canUnderstand: #genders:).

	"Attempt to create users getter and selector again"

	(RBCreateDomainSlotAcccessorsForVariableRefactoring
		instanceVariable: 'genders'
		class: LxxBarebonesSystem) execute.

	self assert: (LxxBarebonesSystem canUnderstand: #genders).
	self assert: (LxxBarebonesSystem canUnderstand: #genders:).
	self deny: (LxxBarebonesSystem canUnderstand: #genders1).
	self deny: (LxxBarebonesSystem canUnderstand: #genders1:)
]

{ #category : #tests }
LcsGlobalSlotDefinitionBuilderTest >> usersGlobalCollectionBuilder [
	^ LcsGlobalSlotDefinitionBuilder new
		slotName: 'users';
		moduleName: LxxBarebonesSystem moduleName;
		slotClass: 'LxxUsers' asClass;
		collectionSlotCollectionClass: LcsSmalltalkConfiguration identitySetClass;
		collectionElementTypes: {'LxxUser' asClass};
		yourself
]
