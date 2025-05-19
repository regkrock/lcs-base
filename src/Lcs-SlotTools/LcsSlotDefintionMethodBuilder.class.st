Class {
	#name : #LcsSlotDefintionMethodBuilder,
	#superclass : #LcsSlotDetailBuilder,
	#instVars : [
		'validationConditions',
		'slotDefinitionClass',
		'slotTypes',
		'properties'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #'instance  creation' }
LcsSlotDefintionMethodBuilder class >> newFrom: aSlotDefinitionBuilder [
	^ self new
		initializeFrom: aSlotDefinitionBuilder;
		yourself
]

{ #category : #'initialize\t' }
LcsSlotDefintionMethodBuilder >> addProperty: aString value: anObject [
	self properties add: aString->anObject
]

{ #category : #'gt views' }
LcsSlotDefintionMethodBuilder >> addRefactoringTextDetailsTo: aStream [
	aStream 
		nextPutAll: (self targetClassName ifNil: [ '<missing target class name>']); 
		nextPutAll:' class >>';
		nextPutAll: self slotDefinitionSource
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
	self targetClass isNil ifTrue: [ ^ aView empty ].
	^ aView explicit
		title: 'Implementor(Slot Definition)';
		priority: 200;
		stencil: [  
			self targetClassName gtClassMatches &
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
	self properties: OrderedCollection new
]

{ #category : #'instance  creation' }
LcsSlotDefintionMethodBuilder >> initializeFrom: aSlotDefinitionBuilder [ 
	self 
		slotName: aSlotDefinitionBuilder slotName;
		slotDefinitionClass: aSlotDefinitionBuilder slotDefinitionClassName asClass;
		targetClassName: aSlotDefinitionBuilder targetClassName;
		slotTypes: aSlotDefinitionBuilder slotTypes copy;
		validationConditions: aSlotDefinitionBuilder validationConditions.
	aSlotDefinitionBuilder addExtraPropertiesTo: self
]

{ #category : #building }
LcsSlotDefintionMethodBuilder >> installCode [
	self addRefactoring: (
		RBAddMethodChange
			compile: self slotDefinitionSource
			in: self targetClass class
			classified: #'slot definition') execute.
	self beCodeInstalled
]

{ #category : #printing }
LcsSlotDefintionMethodBuilder >> jobStepActionDescription [
	^ 'Install slot definition for'
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> properties [
	^ properties
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> properties: anObject [
	properties := anObject
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
	self properties do: [ :each |
		codeStream addKeyword: each key argument: each value ].


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

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass class removeSelector: self slotDefinitionSelector ]
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> validatePropertiesIn: slotDefinition [
	self properties do: [ :each | 
		each key = 'addCollectionMemberType' 
			ifTrue: [ 
				self assert: ((slotDefinition perform: #collectionMemberTypes)
									 includes: each value asClass). ]
			ifFalse: [ self
						assert: (slotDefinition perform: each key asSymbol) printString
						equals: each value ] ]
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
	| slotDefinition |
	self
		assert: (self targetClass class canUnderstand: self slotDefinitionSelector).
	slotDefinition := self targetClass
			perform: self slotDefinitionSelector asSymbol.
	self assert: slotDefinition class == self slotDefinitionClass.
	self assert: slotDefinition slotName = self slotName.
	self assert: slotDefinition slotTypes notEmpty.
	self assert: (slotDefinition slotTypes allSatisfy: [ :each | each isClass ]).
	self validatePropertiesIn: slotDefinition
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> verifySlotModelUpdatesMadeByBuilder [
	self currentSystem isNil ifTrue: [ ^ self ].
	super verifySlotModelUpdatesMadeByBuilder.
	self assert: (self targetClass slotModel slotDefinitionNamed: self slotName) notNil
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> verifyUninstall [
	super verifyUninstall.
	self targetClass isNil ifTrue: [ ^ self ].
	self assert: (self targetClass class canUnderstand: self slotDefinitionSelector) not
]
