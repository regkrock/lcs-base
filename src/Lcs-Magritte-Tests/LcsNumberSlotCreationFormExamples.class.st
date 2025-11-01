Class {
	#name : #LcsNumberSlotCreationFormExamples,
	#superclass : #LcsSmalltalkObjectSlotExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #examples }
LcsNumberSlotCreationFormExamples >> amountSlotCreationForm [
	<gtExample>
	<return: #LcsSlotCreationForm>
	| form |
	form := self slotAccessorSlotCreationForm.
	form slotModelBuilder slotName: 'amount'.
	^ form
]

{ #category : #examples }
LcsNumberSlotCreationFormExamples >> slotAccessorSlotCreationForm [
	<gtExample>
	<return: #LcsSlotCreationForm>
	^ super slotAccessorSlotCreationForm
]

{ #category : #configuration }
LcsNumberSlotCreationFormExamples >> slotClass [
	^LcsNumberSlot
]

{ #category : #examples }
LcsNumberSlotCreationFormExamples >> slotSubjectScripter [
	<gtExample>
	<return: #BlScripter>
	super slotSubjectScripter
]
