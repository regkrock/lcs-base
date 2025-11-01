Class {
	#name : #LcsDateSlotCreationFormExamples,
	#superclass : #LcsSmalltalkObjectSlotExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #examples }
LcsDateSlotCreationFormExamples >> myDateSlotCreationForm [
	<gtExample>
	<return: #LcsSlotCreationForm>
	| form |
	form := self slotAccessorSlotCreationForm.
	form slotModelBuilder slotName: 'myDate'.
	^ form
]

{ #category : #examples }
LcsDateSlotCreationFormExamples >> slotAccessorSlotCreationForm [
	<gtExample>
	<return: #LcsSlotCreationForm>
	^ super slotAccessorSlotCreationForm
]

{ #category : #configuration }
LcsDateSlotCreationFormExamples >> slotClass [
	^ LcsDateSlot
]

{ #category : #examples }
LcsDateSlotCreationFormExamples >> slotSubjectScripter [
	<gtExample>
	<return: #BlScripter>
	super slotSubjectScripter
]
