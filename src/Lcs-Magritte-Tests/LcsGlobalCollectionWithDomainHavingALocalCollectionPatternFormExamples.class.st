Class {
	#name : #LcsGlobalCollectionWithDomainHavingALocalCollectionPatternFormExamples,
	#superclass : #LcsMultislotPatternFormExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #configuration }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternFormExamples >> formClass [
	^ LcsGlobalCollectionWithDomainHavingALocalCollectionPatternForm
]

{ #category : #'examples - form' }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternFormExamples >> globalAddressCollectionWithLocalPersonAddressCollection [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	| form |
	form := self mainForm.
	form slotModelBuilder
		classRootName: 'Address';
		installMemberSlotInDomainClass: LxxPerson;
		installMemberSlotInDomainClass: LxxOrganization.
	self simulateClickOnAcceptButtonIn: form.
	^ form
]

{ #category : #'examples - form' }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternFormExamples >> mainForm [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	| form |
	form := super mainForm.
	self
		assert: form slotModelBuilder collectionSlotInstallationTargetClass
		equals: self targetClass.
	^ form
]

{ #category : #configuration }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternFormExamples >> targetClass [
	^ LxxPrototypeSystem
]
