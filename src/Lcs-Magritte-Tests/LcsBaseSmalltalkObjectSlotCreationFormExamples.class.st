Class {
	#name : 'LcsBaseSmalltalkObjectSlotCreationFormExamples',
	#superclass : 'LcsMagritteFormExamples',
	#category : 'Lcs-Magritte-Tests-Examples',
	#package : 'Lcs-Magritte-Tests',
	#tag : 'Examples'
}

{ #category : 'configuration' }
LcsBaseSmalltalkObjectSlotCreationFormExamples >> installationClass [
	^ LxxPerson
]

{ #category : 'private' }
LcsBaseSmalltalkObjectSlotCreationFormExamples >> nilDescriptionSelectors [
	^ #(numberOfDecimalsDescription) 
]

{ #category : 'private' }
LcsBaseSmalltalkObjectSlotCreationFormExamples >> requiredDescriptionSelectors [
	^ #(#slotClassDescription #targetClassDescription #slotNameDescription #allowNilDescription #requiredDescription initialValueBlockDescription prevalidationTransformBlockDescription validationConditionsDescription slotTypesDescription ) asOrderedCollection
]

{ #category : 'scripter - model' }
LcsBaseSmalltalkObjectSlotCreationFormExamples >> slotAccessorSlotCreationForm [
	"<gtExample>"

	| form |
	self ensureCurrentSystemIsPrototypeSystem.
	form := (LcsSlotCreationFormExamples new slotCreationFormOn: self installationClass)
			slotClassChangedTo: self slotClassName.
	self assert: form slotClassName equals: self slotClassName.
	self
		assert: form slotModelBuilder class name asString
		equals: self slotModelBuilderClassName.
	self requiredDescriptionSelectors
		do: [ :eachDescriptionSelector | (form perform: eachDescriptionSelector) notNil ].
	self nilDescriptionSelectors
		do: [ :eachDescriptionSelector | self assert: (form perform: eachDescriptionSelector) isNil ].
	^ form
]

{ #category : 'configuration' }
LcsBaseSmalltalkObjectSlotCreationFormExamples >> slotBuilderClass [
	^ (self slotClass name , 'Builder') asClass
]

{ #category : 'configuration' }
LcsBaseSmalltalkObjectSlotCreationFormExamples >> slotClass [
	self subclassResponsibility
]

{ #category : 'configuration' }
LcsBaseSmalltalkObjectSlotCreationFormExamples >> slotClassName [
	^ self slotClass name asString
]

{ #category : 'configuration' }
LcsBaseSmalltalkObjectSlotCreationFormExamples >> slotModelBuilderClassName [
	^ self slotBuilderClass name asString
]

{ #category : 'scripter - model' }
LcsBaseSmalltalkObjectSlotCreationFormExamples >> slotSubjectScripter [
	"<gtExample>
	<return: #BlScripter>"
	| aScripter |
	self ensureCurrentSystemIsPrototypeSystem.
	aScripter := self
			scripterWithModel: [ self slotAccessorSlotCreationForm ]
			element: [ :aModel | aModel asGtMagritteViewModel asElement ].

	self
		assert: aScripter
		model: aScripter model
		acceptEnabled: false
		cancelEnabled: true
		buildEnabled: false.
		
	^ aScripter
]
