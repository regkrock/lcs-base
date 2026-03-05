Class {
	#name : 'LcsSingletonValueObjectClassesBuilderJobExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsSingletonValueObjectClassesBuilderJobExamples >> genderSingletonPatternBuilderJob [
	<gtExample>
	| builderJob |
	builderJob := self newBuilderJob
					classPrefix: 'Lxx';
					createForRootName: 'Gender';
					installNewClassesInPackageNamed: 'Lcs-Temp';
					installCollectionSlotInClass: LxxPersonsModule;
					addValueObjectSubclassWithRootNamed: 'Male';
					addValueObjectSubclassWithRootNamed: 'Female';
					addValueObjectSubclassWithRootNamed: 'UnknownGender'
						with: [ :classBuilder | classBuilder beDefaultInstance ];
					targetModuleClass: LxxPrototypeSystem;
					installMemberSlotInDomainClass: LxxBasePerson;
					yourself.
	builderJob buildJobSteps.
	^ builderJob 
]

{ #category : 'examples' }
LcsSingletonValueObjectClassesBuilderJobExamples >> installAndRemoveGenderSingletonPatternClasses [
	<gtExample>
	| builderJob |
	self ensureCurrentSystemIsPrototypeSystem.
	builderJob :=  self genderSingletonPatternBuilderJob.
	[
	  builderJob execute.
	  builderJob verifyCodeInstallation.
	  self verifyGenderAvailableByCreatingNewPerson. ]
		ensure: [
			builderJob uninstall.
			builderJob verifyUninstall ].
	^ builderJob
]

{ #category : 'examples' }
LcsSingletonValueObjectClassesBuilderJobExamples >> installGenderSingletonPatternClasses [
	"<gtExample>
	| builderJob person |
	builderJob :=  self genderSingletonPatternBuilderJob.
	[
		builderJob execute.
		builderJob verifyCodeInstallation.
		person := LxxPerson new.
		self verifyGenderAvailableByCreatingNewPerson. ]
		ensure: [
			builderJob uninstall.
			builderJob verifyUninstall ].
	^ builderJob"
]

{ #category : 'examples' }
LcsSingletonValueObjectClassesBuilderJobExamples >> newBuilderJob [
	<gtExample>
	| builderJob |
	self ensureCurrentSystemIsPrototypeSystem.

	builderJob :=  LcsSingletonValueObjectClassesBuilderJob new.
	^ builderJob
]

{ #category : 'verification' }
LcsSingletonValueObjectClassesBuilderJobExamples >> verifyGenderAvailableByCreatingNewPerson [
	  | person |
	  person := LxxPerson new.
	  self
		assert: person gender
		identicalTo: (self currentSystem moduleNamed: LxxPersonsModule defaultModuleName) genders
				defaultInstance.
]
