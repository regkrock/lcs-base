Class {
	#name : #LcsSmalltalkObjectSlotExamples,
	#superclass : #LcsMagritteFormExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #examples }
LcsSmalltalkObjectSlotExamples >> installationClass [
	^ LxxPerson
]

{ #category : #private }
LcsSmalltalkObjectSlotExamples >> nilDescriptionSelectors [
	^ #(numberOfDecimalsDescription) 
]

{ #category : #private }
LcsSmalltalkObjectSlotExamples >> requiredDescriptionSelectors [
	^ #(#slotClassDescription #targetClassDescription #slotNameDescription #allowNilDescription #requiredDescription initialValueBlockDescription prevalidationTransformBlockDescription validationConditionsDescription slotTypesDescription ) asOrderedCollection
]

{ #category : #examples }
LcsSmalltalkObjectSlotExamples >> slotAccessorSlotCreationForm [
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

{ #category : #configuration }
LcsSmalltalkObjectSlotExamples >> slotBuilderClass [
	^ (self slotClass name , 'Builder') asClass
]

{ #category : #configuration }
LcsSmalltalkObjectSlotExamples >> slotClass [
	self subclassResponsibility
]

{ #category : #configuration }
LcsSmalltalkObjectSlotExamples >> slotClassName [
	^ self slotClass name asString
]

{ #category : #configuration }
LcsSmalltalkObjectSlotExamples >> slotModelBuilderClassName [
	^ self slotBuilderClass name asString
]

{ #category : #examples }
LcsSmalltalkObjectSlotExamples >> slotSubjectScripter [
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
