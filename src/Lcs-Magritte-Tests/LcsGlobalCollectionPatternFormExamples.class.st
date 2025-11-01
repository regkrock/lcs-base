Class {
	#name : #LcsGlobalCollectionPatternFormExamples,
	#superclass : #LcsMultislotPatternFormExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #'examples - form' }
LcsGlobalCollectionPatternFormExamples >> addFoosGlobalCollectionWithPersonHavingAFooInstanceForm [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	| form |
	self ensureCurrentsystemIsPrototypeSystem.
	form := self slotCreationFormWithPrefixAndRootNameEntered.
	form slotModelBuilder targetDomainClasses: (OrderedCollection with: LxxPerson).
	self simulateClickOnAcceptButtonIn: form.
	^ form
]

{ #category : #configuration }
LcsGlobalCollectionPatternFormExamples >> formClass [
	^ LcsGlobalCollectionPatternForm
]

{ #category : #'examples - scripter' }
LcsGlobalCollectionPatternFormExamples >> formScripterWithRootNameEntered [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	^ super formScripterWithRootNameEntered
]

{ #category : #'examples - form' }
LcsGlobalCollectionPatternFormExamples >> mainForm [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	| form |
	form := super mainForm.
	self
		assert: form slotModelBuilder collectionSlotInstallationTargetClass
		equals: self targetClass.
	^ form
]

{ #category : #'examples - scripter' }
LcsGlobalCollectionPatternFormExamples >> mainFormScripter [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	| scripter |
	scripter := super mainFormScripter.
	^ scripter
]

{ #category : #'examples - form' }
LcsGlobalCollectionPatternFormExamples >> slotCreationFormWithPrefixAndRootNameEntered [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	| form |
	form := self slotCreationFormWithPrefixEntered.
	form slotModelBuilder createForRootName: 'Foo'.
	self assert: form slotModelBuilder jobSteps isEmpty.
	^form
]

{ #category : #'examples - form' }
LcsGlobalCollectionPatternFormExamples >> slotCreationFormWithPrefixEntered [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	| form |
	form := self mainForm.
	form slotModelBuilder classPrefix: 'Lxx'.
	self assert: form slotModelBuilder jobSteps isEmpty.
	^form
]

{ #category : #configuration }
LcsGlobalCollectionPatternFormExamples >> targetClass [
	^ LxxPrototypeSystem
]
