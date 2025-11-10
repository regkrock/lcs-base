Class {
	#name : #LcsSystemBuilderFormExamples,
	#superclass : #LcsMultislotPatternFormExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #configuration }
LcsSystemBuilderFormExamples >> formClass [
	^ LcsSystemBuilderForm
]

{ #category : #'examples - form' }
LcsSystemBuilderFormExamples >> mainForm [
	<gtExample>
	| form |
	self ensureCurrentSystemIsPrototypeSystem.
	form := self formClass newOn: self targetClass.
	self assert: form isSlotModelBuilderNotReified.
	form slotModelBuilder
		targetPackageName: '';
		targetPackageTagName: 'Core';
		classPrefix: 'Lxx'.
	self assert: form targetClass equals: self targetClass.
	self assert: form slotModelBuilder classPrefix equals: 'Lxx'.
	self assert: form slotModelBuilder class equals: self builderJobClass.
	^ form
]

{ #category : #configuration }
LcsSystemBuilderFormExamples >> targetClass [
	^ LcsSystem
]

{ #category : #'examples  - form' }
LcsSystemBuilderFormExamples >> testSystemExample [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	| form |
	form := self slotCreationFormWithPrefixEntered.
	form slotModelBuilder
		createForRootName: 'TestSystem';
		umlPositions: self testSystemExampleUmlPositions;
		moduleName: 'Test System'.
	self assert: form slotModelBuilder jobSteps isEmpty.
	self simulateClickOnAcceptButtonIn: form.
	^ form
]

{ #category : #'examples  - form' }
LcsSystemBuilderFormExamples >> testSystemExampleUmlPositions [
	^ OrderedCollection new
]
