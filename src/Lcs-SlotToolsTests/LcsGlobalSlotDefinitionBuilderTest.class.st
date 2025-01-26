Class {
	#name : #LcsGlobalSlotDefinitionBuilderTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #running }
LcsGlobalSlotDefinitionBuilderTest >> createLxxUserClass [
	self
		createClassName: 'LxxUser'
		superclassName: 'LcsDomainCollection'
		category: #'Lcs-Temp'
]

{ #category : #running }
LcsGlobalSlotDefinitionBuilderTest >> createLxxUsersClass [
	self
		createClassName: 'LxxUsers'
		superclassName: 'LcsDomainCollection'
		category: #'Lcs-Temp'
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilderTest >> gendersBuilder [
	^ LcsSingletonCodeClassesBuilderJob new
		classPrefix: 'Lxx';
		installNewClassesInPackageNamed: 'Lcs-Temp';
		createForRootName: 'Gender';
		addCodeSubclassWithRootNamed: 'Male';
		addCodeSubclassWithRootNamed: 'Female';
		addCodeSubclassWithRootNamed: 'UnknownGender'
			with: [ :classBuilder | classBuilder beDefaultInstance ];
		installGlobalCollectionSlotInModuleClass: LxxPrototypeSystem;
		installMemberSlotInDomainClass: LxxPrototypePerson;
		yourself
]

{ #category : #running }
LcsGlobalSlotDefinitionBuilderTest >> removeArtifactsRelatedToGendersSlot [
	LxxPrototypePerson removeDomainSlotNamed: 'gender'.
	LxxPrototypeSystem removeDomainSlotNamed: 'genders'.
	LxxPrototypeSystem removeDomainSlotNamed: 'genders1'.
	self removeClassesNamed: #('LxxGender' 'LxxGenders' 'LxxMale' 'LxxFemale' 'LxxUnknownGender').
]

{ #category : #running }
LcsGlobalSlotDefinitionBuilderTest >> removeArtifactsRelatedToUsersSlot [
	LxxPrototypeSystem removeDomainSlotNamed: 'users'.
	self removeClassesNamed: #('LxxUser' 'LxxUsers').

	LxxPrototypeSystem assertDomainSlotRemoved: 'users'.
	self assert: (self classNamed: 'LxxUsers') isNil.
	self assert: (self classNamed: 'LxxUser') isNil
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
	self assert: builder targetClassName equals: LxxPrototypeSystem name asString.
	self assert: builder target equals: LxxPrototypeSystem.
	self assert: builder slotDefinitionSelector equals: 'usersSlotDefinition'.

	builder installCode.

	LxxPrototypeSystem verifyClassHasDomainSlotNamed: 'users'
]

{ #category : #tests }
LcsGlobalSlotDefinitionBuilderTest >> testInstallingUsersGlobalCollectionWithExistingGetterAndSetterForGenderWhichAreNotSetUpForSlots [
	| builder |

	self removeArtifactsRelatedToUsersSlot.
	self removeArtifactsRelatedToGendersSlot.

	builder := self gendersBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation.

	self assert: (LxxPrototypeSystem canUnderstand: #genders).
	self assert: (LxxPrototypeSystem canUnderstand: #genders:).
	
	LxxPrototypeSystem compile: 'genders
	^ genders'.
	LxxPrototypeSystem compile: 'genders: anObject
	genders := anObject'.

	"Attempt to create genders getter and selector again where the existing gender and genders methods do something different"

	(RBCreateDomainSlotAcccessorsForVariableRefactoring
		instanceVariable: 'genders'
		class: LxxPrototypeSystem) execute.

	self assert: (LxxPrototypeSystem canUnderstand: #genders).
	self assert: (LxxPrototypeSystem canUnderstand: #genders:).
	self assert: (LxxPrototypeSystem canUnderstand: #genders1).
	self assert: (LxxPrototypeSystem canUnderstand: #genders1:)
]

{ #category : #tests }
LcsGlobalSlotDefinitionBuilderTest >> testInstallingUsersGlobalCollectionWithExistingGetterAndSetterForGenders [
	| builder |

	self removeArtifactsRelatedToUsersSlot.
	self removeArtifactsRelatedToGendersSlot.

	builder := self gendersBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation.
	
	self assert: (LxxPrototypeSystem canUnderstand: #genders).
	self assert: (LxxPrototypeSystem canUnderstand: #genders:).

	"Attempt to create users getter and selector again"

	(RBCreateDomainSlotAcccessorsForVariableRefactoring
		instanceVariable: 'genders'
		class: LxxPrototypeSystem) execute.

	self assert: (LxxPrototypeSystem canUnderstand: #genders).
	self assert: (LxxPrototypeSystem canUnderstand: #genders:).
	self deny: (LxxPrototypeSystem canUnderstand: #genders1).
	self deny: (LxxPrototypeSystem canUnderstand: #genders1:)
]

{ #category : #tests }
LcsGlobalSlotDefinitionBuilderTest >> usersGlobalCollectionBuilder [
	^ LcsGlobalSlotDefinitionBuilder new
		slotName: 'users';
		targetClassName: LxxPrototypeSystem name;
		targetModuleName: LxxPrototypeSystem moduleName;
		slotClass: 'LxxUsers' asClass;
		collectionClass: LcsSmalltalkConfiguration identitySetClass;
		collectionElementTypes: {'LxxUser' asClass};
		yourself
]
