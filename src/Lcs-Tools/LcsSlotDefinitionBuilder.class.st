Class {
	#name : #LcsSlotDefinitionBuilder,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'slotName',
		'target',
		'slotDefinitionSelector',
		'targetClassName',
		'targetModuleClass'
	],
	#category : #'Lcs-Tools'
}

{ #category : #'instance  creation' }
LcsSlotDefinitionBuilder class >> newOn: aBuilderOrBuilderJob [
	^ self new
		initializeOn: aBuilderOrBuilderJob;
		yourself 
]

{ #category : #configuration }
LcsSlotDefinitionBuilder class >> slotDefinitionClass [
	self subclassResponsibility
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> _target [
	^ target
]

{ #category : #'gt view' }
LcsSlotDefinitionBuilder >> addModelClassesTo: aCollection [
	aCollection addAll: self target withAllSuperclasses
]

{ #category : #'gt view' }
LcsSlotDefinitionBuilder >> addRefactoringTextDetailsTo: aStream [
	self jobSteps do: [ :each |
		each addRefactoringTextDetailsTo: aStream ] separatedBy: [ aStream cr; cr ]
]

{ #category : #'code generation' }
LcsSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
]

{ #category : #printing }
LcsSlotDefinitionBuilder >> addStepNumberTo: aString [
	^ self stepNumber , '.' , aString
]

{ #category : #uninstall }
LcsSlotDefinitionBuilder >> clearTargetClass: aClass [
	self target == aClass
		ifTrue: [ self target: nil ]
]

{ #category : #testing }
LcsSlotDefinitionBuilder >> doesSlotDefinitionMethodExist [
	^ self target class includesSelector: self slotDefinitionSelector
]

{ #category : #testing }
LcsSlotDefinitionBuilder >> doesTargetClassExist [
	^ [ self target isClass ] 
			on: NotFound 
			do: [ :s | s return: false ]
]

{ #category : #validation }
LcsSlotDefinitionBuilder >> ensureSlotDefinitionMethodDoesNotAlreadyExist [
	self doesSlotDefinitionMethodExist
		ifTrue: [ self error: 'Slot definition already exists' ]
]

{ #category : #validation }
LcsSlotDefinitionBuilder >> ensureSlotDoesNotAlreadyExist [
	self isInstanceVariableAlreadyCreated
		ifTrue: [ self error: 'Slot ' , self slotName , 'already exists' ]
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> getterSelector [
	^ self slotName asSymbol
]

{ #category : #'gt view' }
LcsSlotDefinitionBuilder >> gtClassViewOn: aView [
	<gtView>
	self doesTargetClassExist ifFalse: [
		^ aView list
			title: (self targetClassName ifNil: ['No Target Class']) displayString;
			priority: 200;
			items: [ {'Not yet created'} ];
			yourself ].
	^ aView explicit
		title: self target name;
		priority: 200;
		stencil: [ (GtCoderElement forObject: self target) disablePlayPage beNormalLevel ];
		yourself
]

{ #category : #'gt view' }
LcsSlotDefinitionBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ]
]

{ #category : #initialize }
LcsSlotDefinitionBuilder >> initialize [
	super initialize.
	self jobSteps: (LcsCodeBuilderJobSteps newOn: self).
	self jobSteps addJobStep: LcsSlotInstanceVariableBuilder new.
	self jobSteps addJobStep: LcsSlotDefintionMethodBuilder new.
	self jobSteps addJobStep: LcsSlotGetterAndSetterBuilder new.

]

{ #category : #initialize }
LcsSlotDefinitionBuilder >> initializeOn: aBuilderOrBuilderJob [ 
	self parent: aBuilderOrBuilderJob
]

{ #category : #command }
LcsSlotDefinitionBuilder >> installCode [
	self jobSteps installCode
]

{ #category : #command }
LcsSlotDefinitionBuilder >> installSlotDefinition [
	self target installSlotDefinition: self slotDefinitionSelector
]

{ #category : #testing }
LcsSlotDefinitionBuilder >> isInstanceVariableAlreadyCreated [
	^ self target allInstVarNames includes: self slotName
]

{ #category : #printing }
LcsSlotDefinitionBuilder >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: 'Install slot "';
		nextPutAll: (self slotName ifNil: [ '<missing>' ]);
		nextPutAll: '" in ';
		nextPutAll: (self targetClassName ifNil: [ self target ifNotNil: [ self target name ] ]) asString
]

{ #category : #configuration }
LcsSlotDefinitionBuilder >> slotDefinitionClass [
	^ self class slotDefinitionClass
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotDefinitionSelector [
	^ slotDefinitionSelector
		ifNil: [ slotDefinitionSelector := ((self slotName ifNil: [ 'undefined' ]) , 'SlotDefinition') asSymbol ]
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotDefinitionSelector: aSymbol [
	slotDefinitionSelector := aSymbol asSymbol
]

{ #category : #'code generation' }
LcsSlotDefinitionBuilder >> slotDefinitionSource [
	| codeStream |	
	codeStream := LcsMethodStream new.
	codeStream
		startSlotDefintionSource: self slotDefinitionSelector; 
		addSlotDefinitionClassCreatonLine: self slotDefinitionClass;
		addSetter: 'slotName' contents: (self slotName ifNil: [ '<missing>' ]) printString.
		
	self addSlotDefinitionSourceDetailsTo: codeStream. 
		
	^codeStream 
		addYourself;
		contents

]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotName [
	^ slotName
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotName: anObject [
	.
	slotName := (anObject first asLowercase asString , (anObject copyFrom: 2 to: anObject size))
]

{ #category : #printing }
LcsSlotDefinitionBuilder >> stepNumber [
	^ self parent isNil 
		ifTrue: [ '1']
		ifFalse: [ (self parent indexOf: self) printString ]
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> target [
	^target
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> target: aClass [ 
	target := aClass
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetClass [
	^ self target
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetClass: aClass [
	self target: aClass.
	self targetClassName: aClass name
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetClassName [
	^ targetClassName ifNil: [ 
		self target 
			ifNil: [ '<missing target class>' ]
			ifNotNil: [ self target name ] ]
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetClassName: aString [
	targetClassName := aString.
	self target: ([ aString asClass ] on: NotFound do: [:s | s return: nil ]).
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetModuleClass [
	^ targetModuleClass ifNil: [ targetModuleClass := #LcsBaseModule asClass moduleClassNamed: self targetModuleName ]
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetModuleClass: aModuleClass [
	targetModuleClass := aModuleClass
]

{ #category : #verification }
LcsSlotDefinitionBuilder >> targetSlotDefinition [
	^ self target perform: self slotDefinitionSelector
]

{ #category : #command }
LcsSlotDefinitionBuilder >> updateSlotModel [
	self installSlotDefinition
]

{ #category : #command }
LcsSlotDefinitionBuilder >> verifyCodeInstallation [
	| slotDefinition |
	self assert: (self target class includesLocalSelector: self slotDefinitionSelector).
	slotDefinition := self targetSlotDefinition.
	self assert: slotDefinition class == self class slotDefinitionClass.
	self assert: slotDefinition slotName = self slotName.
	self assert: slotDefinition slotTypes notEmpty.
	self assert: (slotDefinition slotTypes allSatisfy: [ :each | each isClass ]).
	self jobSteps verifyCodeInstallation
]

{ #category : #command }
LcsSlotDefinitionBuilder >> verifySlotModelUpdatesMadeByBuilder [
	self jobSteps verifySlotModelUpdatesMadeByBuilder
]

{ #category : #'gt view' }
LcsSlotDefinitionBuilder >> viewCodeButton [
	self _target isNil ifTrue: [ ^ BrButton new ].
	^ self viewClassButtonFor: self target 
]
