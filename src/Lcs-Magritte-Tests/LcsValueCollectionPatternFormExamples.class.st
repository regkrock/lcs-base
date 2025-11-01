Class {
	#name : #LcsValueCollectionPatternFormExamples,
	#superclass : #LcsMultislotPatternFormExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #configuration }
LcsValueCollectionPatternFormExamples >> formClass [
	^ LcsValueCollectionPatternForm
]

{ #category : #'examples - form' }
LcsValueCollectionPatternFormExamples >> mainForm [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	| form |
	form := super mainForm.
	self
		assert: form slotModelBuilder collectionSlotInstallationTargetClass
		equals: self targetClass.
	^ form
]

{ #category : #'examples - form' }
LcsValueCollectionPatternFormExamples >> personTitlesCreationForm [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	| form |
	form := self mainForm.
	form slotModelBuilder 
		classRootName: 'PersonTitle';
		installMemberSlotInDomainClass: LxxPerson.
	self simulateClickOnAcceptButtonIn: form.
	^ form
]

{ #category : #configuration }
LcsValueCollectionPatternFormExamples >> targetClass [
	^ LxxPrototypeSystem
]
