Class {
	#name : #LcsSingletonValueCollectionPatternFormExamples,
	#superclass : #LcsMultislotPatternFormExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #configuration }
LcsSingletonValueCollectionPatternFormExamples >> formClass [
	^ LcsSingletonValueCollectionPatternForm
]

{ #category : #'examples - form' }
LcsSingletonValueCollectionPatternFormExamples >> mainForm [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	^ super mainForm
]

{ #category : #'examples - form' }
LcsSingletonValueCollectionPatternFormExamples >> sampleGenderCreationForm [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	| form |
	form := self mainForm.
	form slotModelBuilder 
		classRootName: 'SampleGender';
		"addValueObjectSubclassWithRootNamed: 'SampleMale';
		addValueObjectSubclassWithRootNamed: 'SampleFemale';
		addValueObjectSubclassWithRootNamed: 'SampleUnknownGender'
			with: [ :classBuilder | classBuilder beDefaultInstance ];"
		installMemberSlotInDomainClass: LxxPerson.
	self simulateClickOnAcceptButtonIn: form.
	^ form
]

{ #category : #configuration }
LcsSingletonValueCollectionPatternFormExamples >> targetClass [
	^ LxxPrototypeSystem
]
