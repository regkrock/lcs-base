Class {
	#name : #LcsModuleBuilderFormExamples,
	#superclass : #LcsMultislotPatternFormExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #configuration }
LcsModuleBuilderFormExamples >> formClass [
	^ LcsModuleBuilderForm
]

{ #category : #'examples - form' }
LcsModuleBuilderFormExamples >> mainForm [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	^ super mainForm
]

{ #category : #'examples  - form' }
LcsModuleBuilderFormExamples >> sailClubModuleExample [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	| form |
	form := self slotCreationFormWithPrefixEntered.
	form slotModelBuilder
		createForRootName: 'SailingClub';
		umlPositions: self sailClubModuleExampleUmlPositions;
		moduleName: 'Sailing Club Module'.
	self assert: form slotModelBuilder jobSteps isEmpty.
	self simulateClickOnAcceptButtonIn: form.
	^ form
]

{ #category : #'examples  - form' }
LcsModuleBuilderFormExamples >> sailClubModuleExampleUmlPositions [
	^ OrderedCollection new
]

{ #category : #configuration }
LcsModuleBuilderFormExamples >> targetClass [
	^ LxxPrototypeSystem
]
