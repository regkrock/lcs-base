Class {
	#name : #LcsDateOfBirthSlotCreationFormExamples,
	#superclass : #LcsSmalltalkObjectSlotExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #configuration }
LcsDateOfBirthSlotCreationFormExamples >> installationClass [
	^ LxxPrototypeSystem
]

{ #category : #examples }
LcsDateOfBirthSlotCreationFormExamples >> myDateOfBirthSlotCreationForm [
	<gtExample>
	<return: #LcsSlotCreationForm>
	| form |
	form := self slotAccessorSlotCreationForm.
	^ form
]

{ #category : #examples }
LcsDateOfBirthSlotCreationFormExamples >> slotAccessorSlotCreationForm [
	<gtExample>
	<return: #LcsSlotCreationForm>
	^ super slotAccessorSlotCreationForm
]

{ #category : #configuration }
LcsDateOfBirthSlotCreationFormExamples >> slotBuilderClass [
	^ LcsDateSlotBuilder
]

{ #category : #configuration }
LcsDateOfBirthSlotCreationFormExamples >> slotClass [
	^ LcsDateOfBirthSlot
]

{ #category : #examples }
LcsDateOfBirthSlotCreationFormExamples >> slotCreationForm [
	<gtExample>
	<return: #LcsSlotCreationForm>
	| form |
	form := self slotAccessorSlotCreationForm.
	"form slotModelBuilder slotName: 'myDateOfBirth'."
	^ form
]
