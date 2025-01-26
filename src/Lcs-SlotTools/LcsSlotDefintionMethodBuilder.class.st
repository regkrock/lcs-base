Class {
	#name : #LcsSlotDefintionMethodBuilder,
	#superclass : #LcsSlotDetailBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #'gt v' }
LcsSlotDefintionMethodBuilder >> addRefactoringTextDetailsTo: aStream [
	aStream nextPutAll: self slotDefinitionSource
]

{ #category : #'gt view' }
LcsSlotDefintionMethodBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ]
]

{ #category : #'gt view' }
LcsSlotDefintionMethodBuilder >> gtSlotDefinitionImplementorFor: aView [
	<gtView>
	self target isNil ifTrue: [ ^ aView empty ].
	^ aView explicit
		title: 'Implementor(Slot Definition)';
		priority: 200;
		stencil: [  
			self target name gtClassMatches &
			self slotDefinitionSelector gtImplementors  ]
]

{ #category : #building }
LcsSlotDefintionMethodBuilder >> installCode [
	self addRefactoring: (
		RBAddMethodChange
			compile: self slotDefinitionSource
			in: self target class
			classified: #'slot definition') execute.
	self beCodeInstalled
]

{ #category : #printing }
LcsSlotDefintionMethodBuilder >> jobStepActionDescription [
	^ 'Install slot definition for'
]

{ #category : #'as yet unclassified' }
LcsSlotDefintionMethodBuilder >> slotDefinitionSelector [
	^ (self slotName , 'SlotDefinition') asSymbol
]

{ #category : #'as yet unclassified' }
LcsSlotDefintionMethodBuilder >> targetClassName [
	^ self parent targetClassName
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> verifyCodeInstallation [
	self assert: (self target class canUnderstand: self slotBuilder slotDefinitionSelector)
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> verifySlotModelUpdatesMadeByBuilder [
	self assert: (self target slotModel slotDefinitionNamed: self slotName) notNil
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> verifyUninstall [
	([ self target ] on: NotFound do: [ :s | s return: nil ]) ifNil: [ ^ self ].
	self assert: (self target class canUnderstand: self slotBuilder slotDefinitionSelector) not
]
