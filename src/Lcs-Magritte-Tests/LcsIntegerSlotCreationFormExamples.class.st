Class {
	#name : #LcsIntegerSlotCreationFormExamples,
	#superclass : #LcsSmalltalkObjectSlotExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #examples }
LcsIntegerSlotCreationFormExamples >> amountSlotCreationForm [
	<gtExample>
	<return: #LcsSlotCreationForm>
	| form |
	form := self slotAccessorSlotCreationForm.
	form slotModelBuilder slotName: 'amount'.
	^ form
]

{ #category : #examples }
LcsIntegerSlotCreationFormExamples >> slotAccessorSlotCreationForm [
	<gtExample>
	<return: #LcsSlotCreationForm>
	^ super slotAccessorSlotCreationForm
]

{ #category : #configuration }
LcsIntegerSlotCreationFormExamples >> slotClass [
	^LcsIntegerSlot
]

{ #category : #examples }
LcsIntegerSlotCreationFormExamples >> slotSubjectScripter [
	<gtExample>
	<return: #BlScripter>
	super slotSubjectScripter
]
