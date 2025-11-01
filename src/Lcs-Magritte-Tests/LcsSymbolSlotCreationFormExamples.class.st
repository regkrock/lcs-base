Class {
	#name : #LcsSymbolSlotCreationFormExamples,
	#superclass : #LcsSmalltalkObjectSlotExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #examples }
LcsSymbolSlotCreationFormExamples >> myymbolSlotCreationForm [
	<gtExample>
	<return: #LcsSlotCreationForm>
	| form |
	form := self slotAccessorSlotCreationForm.
	form slotModelBuilder slotName: 'xxx'.
	^ form
]

{ #category : #examples }
LcsSymbolSlotCreationFormExamples >> slotAccessorSlotCreationForm [
	<gtExample>
	<return: #LcsSlotCreationForm>
	^ super slotAccessorSlotCreationForm
]

{ #category : #configuration }
LcsSymbolSlotCreationFormExamples >> slotClass [
	^ LcsSymbolSlot
]

{ #category : #configuration }
LcsSymbolSlotCreationFormExamples >> slotModelBuilderClassName [
	^ LcsStringSlot name , 'Builder'
]

{ #category : #examples }
LcsSymbolSlotCreationFormExamples >> slotSubjectScripter [
	<gtExample>
	<return: #BlScripter>
	super slotSubjectScripter
]
