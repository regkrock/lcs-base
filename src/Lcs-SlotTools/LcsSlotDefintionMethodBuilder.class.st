Class {
	#name : #LcsSlotDefintionMethodBuilder,
	#superclass : #LcsSlotDetailBuilder,
	#instVars : [
		'validationConditions',
		'slotDefinitionClass',
		'slotTypes'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #'gt views' }
LcsSlotDefintionMethodBuilder >> addRefactoringTextDetailsTo: aStream [
	aStream nextPutAll: self slotDefinitionSource
]

{ #category : #'code generation' }
LcsSlotDefintionMethodBuilder >> addSlotTypesSourceCodeTo: codeStream [
	self hasNoSlotTypes ifTrue: [ 
		codeStream
			addKeyword: 'addSlotType'
			argument: '<no slot types defined>' printString.
		^ self ].
	self slotTypes
		do: [ :eachName | codeStream addKeyword: 'addSlotType' argument: eachName ]
]

{ #category : #'code generation' }
LcsSlotDefintionMethodBuilder >> addValidationCondition: aStringBlock description: aDescription [
	self validationConditions add: aStringBlock -> aDescription
]

{ #category : #'gt views' }
LcsSlotDefintionMethodBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ]
]

{ #category : #'gt views' }
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

{ #category : #testing }
LcsSlotDefintionMethodBuilder >> hasNoSlotTypes [
	^ self slotTypes isEmpty and: [ self slotDefinitionClassHasNoSlotTypes ]
]

{ #category : #'initialize\t' }
LcsSlotDefintionMethodBuilder >> initialize [ 
	super initialize.
	self validationConditions: OrderedCollection new.
	self slotTypes: OrderedCollection new.
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

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> slotDefinitionClass [
	^ slotDefinitionClass
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> slotDefinitionClass: anObject [
	slotDefinitionClass := anObject
]

{ #category : #testing }
LcsSlotDefintionMethodBuilder >> slotDefinitionClassHasNoSlotTypes [
	^ self slotDefinitionClass notNil
		and: [ self slotDefinitionClass new slotTypes isEmpty ]
]

{ #category : #'code generation' }
LcsSlotDefintionMethodBuilder >> slotDefinitionClassNameDisplayName [
	^ self slotDefinitionClass
		ifNil: [ '<missing>' ]
		ifNotNil: [ :class | class name ]
]

{ #category : #'code generation' }
LcsSlotDefintionMethodBuilder >> slotDefinitionSelector [
	^ (self slotName , 'SlotDefinition') asSymbol
]

{ #category : #'code generation' }
LcsSlotDefintionMethodBuilder >> slotDefinitionSource [
	| codeStream |
	codeStream := LcsMethodStream new.
	codeStream
		startSlotDefintionSource: self slotDefinitionSelector;
		addSlotDefinitionClassCreatonLine: self slotDefinitionClassNameDisplayName;
		addKeyword: 'slotName' argument: self slotNameDisplayName.
	self validationConditions
		do: [ :eachAssociation | 
			codeStream
				addKeyword: 'addValidationCondition'
				argument: eachAssociation key
				keyword: 'description'
				argument: eachAssociation value printString ].
	self addSlotTypesSourceCodeTo: codeStream.


	^ codeStream
		addYourself;
		contents
]

{ #category : #'code generation' }
LcsSlotDefintionMethodBuilder >> slotNameDisplayName [
	^ (self slotName ifNil: [ '<missing>' ]) printString
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> slotTypes [
	^ slotTypes
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> slotTypes: anObject [
	slotTypes := anObject
]

{ #category : #asking }
LcsSlotDefintionMethodBuilder >> targetClassName [
	^ self parent targetClassName
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> validationConditions [
	^ validationConditions
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> validationConditions: anObject [
	validationConditions := anObject
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> verifyCodeInstallation [
	self assert: (self target class canUnderstand: self slotBuilder slotDefinitionSelector)
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> verifySlotModelUpdatesMadeByBuilder [
	self currentSystem isNil ifTrue: [ ^ self ].
	self assert: (self target slotModel slotDefinitionNamed: self slotName) notNil
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> verifyUninstall [
	([ self target ] on: NotFound do: [ :s | s return: nil ]) ifNil: [ ^ self ].
	self assert: (self target class canUnderstand: self slotBuilder slotDefinitionSelector) not
]
