Class {
	#name : #LcsScaledDecimalSlotCreationFormExamples,
	#superclass : #LcsSmalltalkObjectSlotExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #examples }
LcsScaledDecimalSlotCreationFormExamples >> amountSlotCreationForm [
	<gtExample>
	<return: #LcsSlotCreationForm>
	| form |
	form := self slotAccessorSlotCreationForm.
	form slotModelBuilder slotName: 'amount'.
	^ form
]

{ #category : #private }
LcsScaledDecimalSlotCreationFormExamples >> nilDescriptionSelectors [
	^ #()
]

{ #category : #private }
LcsScaledDecimalSlotCreationFormExamples >> requiredDescriptionSelectors [
	^ super requiredDescriptionSelectors
		add: #numberOfDecimalsDescription;
		yourself
]

{ #category : #examples }
LcsScaledDecimalSlotCreationFormExamples >> slotAccessorSlotCreationForm [
	<gtExample>
	<return: #LcsSlotCreationForm>
	^ super slotAccessorSlotCreationForm
]

{ #category : #configuration }
LcsScaledDecimalSlotCreationFormExamples >> slotClass [
	^LcsScaledDecimalSlot
]

{ #category : #examples }
LcsScaledDecimalSlotCreationFormExamples >> slotSubjectScripter [
	<gtExample>
	<return: #BlScripter>
	super slotSubjectScripter
]
