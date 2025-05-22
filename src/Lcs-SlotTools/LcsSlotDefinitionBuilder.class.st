Class {
	#name : #LcsSlotDefinitionBuilder,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'slotName',
		'slotDefinitionSelector',
		'targetClassName',
		'targetModuleClass',
		'slotDefinitionClassName',
		'slotTypes',
		'validationConditions',
		'targetPackageName',
		'targetClass'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #'instance creation' }
LcsSlotDefinitionBuilder class >> newOn: aBuilderOrBuilderJob [
	^ self new
		initializeOn: aBuilderOrBuilderJob;
		yourself 
]

{ #category : #configuration }
LcsSlotDefinitionBuilder class >> slotDefinitionClass [
	"Subclasses can override this method to provide a default"
	^ nil
]

{ #category : #initialize }
LcsSlotDefinitionBuilder >> addExtraPropertiesTo: aSlotDefinitionMethodBuilder [
]

{ #category : #'gt views' }
LcsSlotDefinitionBuilder >> addModelClassesTo: aCollection [
	aCollection addAll: self targetClass withAllSuperclasses
]

{ #category : #'gt views' }
LcsSlotDefinitionBuilder >> addRefactoringTextDetailsTo: aStream [
	self jobSteps do: [ :each |
		each addRefactoringTextDetailsTo: aStream ] separatedBy: [ aStream cr; cr ]
]

{ #category : #'code generation' }
LcsSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
]

{ #category : #initialize }
LcsSlotDefinitionBuilder >> addSlotType: aClassOrClassName [
	self slotTypes add: (aClassOrClassName isClass ifTrue: [ aClassOrClassName name ] ifFalse: [ aClassOrClassName ])
]

{ #category : #printing }
LcsSlotDefinitionBuilder >> addStepNumberTo: aString [
	^ self stepNumber , '.' , aString
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> addValidationCondition: aStringBlock description: aDescription [
	self validationConditions add: aStringBlock -> aDescription
]

{ #category : #'job steps' }
LcsSlotDefinitionBuilder >> buildJobSteps [
	self addJobStep: self slotInstanceVariableBuilder.
	self addJobStep: self slotDefinitionMethodBuilder.
	self addJobStep: self getterAndSetterMethodsBuilder
]

{ #category : #uninstall }
LcsSlotDefinitionBuilder >> clearTargetClass: aClass [
	self targetClass == aClass
		ifTrue: [ self targetClassName: nil ]
]

{ #category : #testing }
LcsSlotDefinitionBuilder >> doesSlotDefinitionMethodExist [
	^ self targetClass class includesSelector: self slotDefinitionSelector
]

{ #category : #testing }
LcsSlotDefinitionBuilder >> doesTargetClassExist [
	^ self targetClass isClass
]

{ #category : #validation }
LcsSlotDefinitionBuilder >> ensureSlotDefinitionMethodDoesNotAlreadyExist [
	self doesSlotDefinitionMethodExist
		ifTrue: [ self error: 'Slot definition already exists' ]
]

{ #category : #initialize }
LcsSlotDefinitionBuilder >> getterAndSetterMethodsBuilder [
	^ LcsSlotGetterAndSetterBuilder new
		slotName: self slotName;
		targetClassName: self targetClassName;
		yourself
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> getterSelector [
	^ self slotName asSymbol
]

{ #category : #'gt views' }
LcsSlotDefinitionBuilder >> gtClassViewOn: aView [
	<gtView>
	self doesTargetClassExist ifFalse: [
		^ aView list
			title: (self targetClassName ifNil: ['No Target Class']) displayString;
			priority: 200;
			items: [ {'Not yet created'} ];
			yourself ].
	^ aView explicit
		title: self targetClass name;
		priority: 200;
		stencil: [ (GtCoderElement forObject: self targetClass) disablePlayPage beNormalLevel ];
		yourself
]

{ #category : #'gt views' }
LcsSlotDefinitionBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 3;
		text: [ self refactoringText asRopedText ];
		actionUpdateButton

]

{ #category : #initialize }
LcsSlotDefinitionBuilder >> initialize [
	super initialize.
	self slotTypes: OrderedCollection new.
	self validationConditions: OrderedCollection new.
	self class slotDefinitionClass notNil
		ifTrue: [ self slotDefinitionClassName: self class slotDefinitionClass name ].
	self jobSteps: (LcsCodeBuilderJobSteps newOn: self)
]

{ #category : #initialize }
LcsSlotDefinitionBuilder >> initializeOn: aBuilderOrBuilderJob [ 
	self parent: aBuilderOrBuilderJob
]

{ #category : #command }
LcsSlotDefinitionBuilder >> installCode [
	self traceStep: 'installCode'.
	self jobSteps installCode
]

{ #category : #'job steps' }
LcsSlotDefinitionBuilder >> installSlotDefinition [
	self targetClass installSlotDefinition: self slotDefinitionSelector
]

{ #category : #printing }
LcsSlotDefinitionBuilder >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: 'Install slot "';
		nextPutAll: (self slotName ifNil: [ '<missing>' ]);
		nextPutAll: '" in ';
		nextPutAll: (self targetClassName ifNil: [ self targetClass ifNotNil: [ self targetClass name ] ]) asString
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotDefinitionClassName [
	^ slotDefinitionClassName
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotDefinitionClassName: anObject [
	slotDefinitionClassName := anObject
]

{ #category : #initialize }
LcsSlotDefinitionBuilder >> slotDefinitionMethodBuilder [
	^ LcsSlotDefintionMethodBuilder newFrom: self
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
	1 halt.
	"| codeStream |	
	codeStream := LcsMethodStream new.
	codeStream
		startSlotDefintionSource: self slotDefinitionSelector; 
		addSlotDefinitionClassCreatonLine: self slotDefinitionClass;
		addSetter: 'slotName' contents: (self slotName ifNil: [ '<missing>' ]) printString.
		
	self addSlotDefinitionSourceDetailsTo: codeStream. 
		
	^codeStream 
		addYourself;
		contents"

]

{ #category : #initialize }
LcsSlotDefinitionBuilder >> slotInstanceVariableBuilder [
	^ LcsSlotInstanceVariableBuilder new
		slotName: self slotName;
		targetClassName: self targetClassName;
		yourself
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

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotTypes [
	^ slotTypes
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotTypes: anObject [
	slotTypes := anObject
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetClass [
	^ self targetClassName ifNotNil: [ 
		[ self targetClassName asClass ] 
			on: NotFound 
			do: [ :s | s return: nil ] ]
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetClass: aClass [
	self targetClassName: aClass name
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetClassName [
	^ targetClassName
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetClassName: aString [
	targetClassName := aString
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetModuleClass [
	^ targetModuleClass
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetModuleClass: aModuleClass [
	targetModuleClass := aModuleClass
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetPackageName [
	^ targetPackageName
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetPackageName: anObject [
	targetPackageName := anObject
]

{ #category : #verification }
LcsSlotDefinitionBuilder >> targetSlotDefinition [
	^ self targetClass perform: self slotDefinitionSelector
]

{ #category : #command }
LcsSlotDefinitionBuilder >> updateSlotModel [
	super updateSlotModel.
	self installSlotDefinition
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> validationConditions [
	^ validationConditions
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> validationConditions: anObject [
	validationConditions := anObject
]

{ #category : #'gt views' }
LcsSlotDefinitionBuilder >> viewCodeButton [
	self targetClass isNil ifTrue: [ ^ BrButton new ].
	^ self viewClassButtonFor: self targetClass 
]
