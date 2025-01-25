Class {
	#name : #LcsDomainClassClassesBuilderJobTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #tests }
LcsDomainClassClassesBuilderJobTest >> jobBuilder [
	^ LcsGlobalDomainClassClassesBuilderJob new
		classPrefix: 'Lxx';
		installNewClassesInPackageNamed: 'Lcs-Temp';
		createForRootName: 'Country';
		createInstances: #( #('CA' 'Canada') #('US' 'United States Of America'));
		installGlobalCollectionSlotInModuleClass: LxxPrototypeSystem;
		installMemberSlotInDomainClass: LxxPrototypePerson;
		yourself
]

{ #category : #running }
LcsDomainClassClassesBuilderJobTest >> removeAllArtifacts [
	LxxPrototypeSystem removeDomainSlotNamed: 'countries'.
	LxxPrototypePerson removeDomainSlotNamed: 'country'.
	self
		removeClassesNamed: #('LxxUnknownCountry' 'LxxCountry' 'LxxCountries')
]

{ #category : #running }
LcsDomainClassClassesBuilderJobTest >> tearDown [
	self removeAllArtifacts.
	super tearDown
]

{ #category : #tests }
LcsDomainClassClassesBuilderJobTest >> testCreatingCountryDomainClass_Phase1_BuildJob [
	| builder |
	builder := self jobBuilder.

	self assert: builder classPrefix equals: 'Lxx'.
	self assert: builder targetPackageName equals: 'Lcs-Temp'.
	self assert: builder completedRefactorings isEmpty.
	self assert: builder classRootName equals: 'Country'.
	self assert: builder jobSteps hasNoJobSteps.

	self assert: builder domainInstanceSlotName equals: 'country'.
	self assert: builder globalCollectionSlotName equals: 'countries'.
	self assert: builder newDomainClassName equals: 'LxxCountry'.
	self assert: builder newGlobalCollectionClassName equals: 'LxxCountries'.
	self assert: builder globalCollectionModuleClass equals: LxxPrototypeSystem.
	self assert:builder unknownClassName equals: 'LxxUnknownCountry'.
]

{ #category : #tests }
LcsDomainClassClassesBuilderJobTest >> testCreatingCountryDomainClass_Phase2_BuildJobStep [
	| builder builderJobStep |

	self assert: self currentSystem notNil.
	builder := self jobBuilder.
	builder buildJobSteps.

	self assert: builder jobSteps collection size equals: 6.
	
	builderJobStep := builder jobSteps jobStepAt: 1.
	self assert: builderJobStep class identicalTo: LcsDomainClassBuilder.
	self assert: builderJobStep targetSuperclassName equals: 'LcsDomainObject'.
	self assert: builderJobStep newClassName equals: 'LxxCountry'.
	self assert: builderJobStep targetPackageName equals: builder targetPackageName.
	
	builderJobStep := builder jobSteps jobStepAt: 2.
	self assert: builderJobStep class identicalTo: LcsUnknownClassBuilder.
	self assert: builderJobStep targetSuperclassName equals: 'LxxCountry'.
	self assert: builderJobStep newClassName equals: 'LxxUnknownCountry'.
	self assert: builderJobStep targetPackageName equals: builder targetPackageName.

	builderJobStep := builder jobSteps jobStepAt: 3.
	self assert: builderJobStep class identicalTo: LcsDomainCollectionClassBuilder.
	self assert: builderJobStep targetSuperclassName equals: 'LcsDomainCollection'.
	self assert: builderJobStep newClassName equals: 'LxxCountries'.
	self assert: builderJobStep targetPackageName equals: builder targetPackageName.
		
	builderJobStep := builder jobSteps jobStepAt: 4.
	self assert: builderJobStep class identicalTo: LcsGlobalCollectionReferenceSlotBuilder.
	self assert: builderJobStep targetClassName equals: 'LxxCountry'.
	self assert: builderJobStep collectionSlotName equals: 'countries'.
	self assert: builderJobStep collectionSlotModule class identicalTo: LxxPrototypeSystem.
	
	builderJobStep := builder jobSteps jobStepAt: 5.
	self assert: builderJobStep class identicalTo: LcsGlobalSlotDefinitionBuilder.
	self assert: builderJobStep target identicalTo: LxxPrototypeSystem.
	self assert: builderJobStep slotTypeClassName equals: 'LxxCountries'.
	self assert: builderJobStep slotName equals: 'countries'.


	builderJobStep := builder jobSteps jobStepAt: 6.
	self assert: builderJobStep class identicalTo: LcsMemberOfSlotBuilder.
	self assert: builderJobStep target identicalTo: LxxPrototypePerson.
	self assert: builderJobStep collectionSlotModuleName identicalTo: LxxPrototypeSystem moduleName.
	self assert: builderJobStep collectionSlotName equals: 'countries'.
	self assert: builderJobStep slotName equals: 'country'.

]

{ #category : #tests }
LcsDomainClassClassesBuilderJobTest >> testCreatingCountryDomainClass_Phase3_InstallCode [
	| builder |
	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation

]

{ #category : #tests }
LcsDomainClassClassesBuilderJobTest >> testCreatingCountryDomainClass_Phase4_UpdateSlotModel [
	| builder |
	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation.
	builder updateSlotModel.
	builder verifySlotModelUpdatesMadeByBuilder
]

{ #category : #tests }
LcsDomainClassClassesBuilderJobTest >> testCreatingCountryDomainClass_Phase5_Populate [
	| builder |
	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation.
	builder updateSlotModel.
	builder verifySlotModelUpdatesMadeByBuilder.
	
	self currentSystem currentUnitOfWork applyChanges.
	
	builder populateSlotModel.
	"builder verifyPopulateSlotModel."

]
