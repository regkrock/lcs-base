Class {
	#name : #LcsBooleanSlotCreationFormExamples,
	#superclass : #LcsSmalltalkObjectSlotExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #examples }
LcsBooleanSlotCreationFormExamples >> myBooleanSlotCreationForm [
	<gtExample>
	<return: #LcsSlotCreationForm>
	| form |
	form := self slotAccessorSlotCreationForm.
	form slotModelBuilder slotName: 'myBoolean'.
	^ form
]

{ #category : #examples }
LcsBooleanSlotCreationFormExamples >> slotAccessorSlotCreationForm [
	<gtExample>
	<return: #LcsSlotCreationForm>
	^ super slotAccessorSlotCreationForm
]

{ #category : #configuration }
LcsBooleanSlotCreationFormExamples >> slotClass [
	^ LcsBooleanSlot
]

{ #category : #examples }
LcsBooleanSlotCreationFormExamples >> slotSubjectScripter [
	<gtExample>
	<return: #BlScripter>
	super slotSubjectScripter
]
