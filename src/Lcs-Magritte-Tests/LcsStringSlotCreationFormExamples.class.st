Class {
	#name : 'LcsStringSlotCreationFormExamples',
	#superclass : 'LcsSmalltalkObjectSlotExamples',
	#category : 'Lcs-Magritte-Tests-Examples',
	#package : 'Lcs-Magritte-Tests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsStringSlotCreationFormExamples >> myStringSlotCreationForm [
	<gtExample>
	<return: #LcsSlotCreationForm>
	| form |
	form := self slotAccessorSlotCreationForm.
	form slotModelBuilder slotName: 'myString'.
	^ form
]

{ #category : 'examples' }
LcsStringSlotCreationFormExamples >> slotAccessorSlotCreationForm [
	<gtExample>
	<return: #LcsSlotCreationForm>
	^ super slotAccessorSlotCreationForm
]

{ #category : 'configuration' }
LcsStringSlotCreationFormExamples >> slotClass [
	^ LcsStringSlot
]

{ #category : 'examples' }
LcsStringSlotCreationFormExamples >> slotSubjectScripter [
	<gtExample>
	<return: #BlScripter>
	super slotSubjectScripter
]
