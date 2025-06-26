Class {
	#name : #LcsSlotDefintionMethodBuilder,
	#superclass : #LcsSlotDetailBuilder,
	#instVars : [
		'validationConditions',
		'slotDefinitionClass',
		'slotDefinitionClassInstance'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #'instance  creation' }
LcsSlotDefintionMethodBuilder class >> newFrom: aSlotDefinitionBuilder [
	^ self new
		initializeFrom: aSlotDefinitionBuilder;
		yourself
]

{ #category : #'code generation' }
LcsSlotDefintionMethodBuilder >> addKeyword: aPropertyName argument: aValue to: aCodeStream [

	(aPropertyName = 'slotName' and: [ aValue isNil ]) ifTrue: [ ^ self ].
	(self slotDefinitionClassInstance isChangedProperty: aPropertyName value: aValue) ifFalse: [ ^self ].
	
	aPropertyName = 'slotTypes' ifTrue: [ 
		^ self addSlotTypesKeyword: aPropertyName argument: aValue to: aCodeStream ].

	"aPropertyName = 'codeSuperclass' ifTrue: [ 
		^ aCodeStream addKeyword: aPropertyName argument: aValue asString  ]."

	aValue isString ifFalse: [
		^ aCodeStream addKeyword: aPropertyName argument: aValue asString].
	
	([ aValue asClass ] on: NotFound do: [ :s | s return: nil ]) notNil ifTrue: [
		^ aCodeStream addKeyword: aPropertyName argument: aValue].

	aPropertyName = 'slotName' ifTrue: [ 
		^ aCodeStream addKeyword: aPropertyName argument: aValue printString ].
		
	aCodeStream addKeyword: aPropertyName argument: aValue
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

{ #category : #'as yet unclassified' }
LcsSlotDefintionMethodBuilder >> addSlotType: aClassorClassName [
	| aClassName |
	aClassName := aClassorClassName isClass 
					ifTrue: [ aClassorClassName name asString]
					ifFalse: [ aClassorClassName ].
	(self slotTypes includes: aClassorClassName) ifFalse: [ 
		self slotTypes add: aClassName ]
]

{ #category : #'code generation' }
LcsSlotDefintionMethodBuilder >> addSlotTypesKeyword: aPropertyName argument: aValue to: aCodeStream [
	| slotTypesCollectionCreationStream |

	aValue isEmpty ifTrue: [ ^ self ].

	slotTypesCollectionCreationStream := WriteStream on: String new.
	slotTypesCollectionCreationStream nextPutAll: '(OrderedCollection'.
	aValue do: [ :eachClassName | slotTypesCollectionCreationStream nextPutAll: ' with: ' , eachClassName ].
	slotTypesCollectionCreationStream nextPutAll: ')'.
	aCodeStream addKeyword: aPropertyName argument: slotTypesCollectionCreationStream contents
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

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> allowNil [
	^ self properties at: 'allowNil' ifAbsentPut: [ false ]
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> allowNil: aBoolean [
	self properties at: 'allowNil' put: aBoolean
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
	self allowNil: false.
	self required: false.
	self slotTypes: OrderedCollection new.

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
	super installCode.
	self addRefactoring: (
		RBAddMethodChange
			compile: self slotDefinitionSource
			in: self targetClass class
			classified: #'slot definitions') execute.
	self beCodeInstalled
]

{ #category : #printing }
LcsSlotDefintionMethodBuilder >> jobStepActionDescription [
	^ 'Install slot definition for'
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> required [
	^ self properties at: 'required' ifAbsentPut: [ false ]
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> required: aBoolean [
	self properties at: 'required' put: aBoolean
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

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> slotDefinitionClassInstance [
	^ slotDefinitionClassInstance ifNil: [ slotDefinitionClassInstance := self slotDefinitionClass new ]
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> slotDefinitionClassInstance: anObject [
	slotDefinitionClassInstance := anObject
]

{ #category : #'code generation' }
LcsSlotDefintionMethodBuilder >> slotDefinitionClassNameDisplayName [
	^ self slotDefinitionClass
		ifNil: [ '<missing>' ]
		ifNotNil: [ :class | class name ]
]

{ #category : #'code generation' }
LcsSlotDefintionMethodBuilder >> slotDefinitionSelector [
	self slotName ifNotNil: [:s | ^ (s , 'SlotDefinition') asSymbol ].
	self slotDefinitionClassInstance ifNil: [ ^ LcsError signal: 'slotName is undefined' ].
	self slotDefinitionClassInstance slotName ifNotNil: [ :s | ^ (s , 'SlotDefinition') asSymbol ].
	LcsError signal: 'slotName is undefined'
]

{ #category : #'code generation' }
LcsSlotDefintionMethodBuilder >> slotDefinitionSource [
	| codeStream |
	self slotDefinitionClassInstance: self slotDefinitionClass new.
	codeStream := LcsMethodStream new.
	codeStream
		startSlotDefintionSource: self slotDefinitionSelector;
		addSlotDefinitionClassCreatonLine: self slotDefinitionClassNameDisplayName.
	self validationConditions
		do: [ :eachAssociation | 
			codeStream
				addKeyword: 'addValidationCondition'
				argument: eachAssociation key
				keyword: 'description'
				argument: eachAssociation value printString ].
	self addSlotTypesSourceCodeTo: codeStream.
	self properties keysAndValuesDo: [ :eachKey :eachValue |
		self addKeyword: eachKey argument: eachValue to: codeStream].


	^ codeStream
		addYourself;
		contents
]

{ #category : #'code generation' }
LcsSlotDefintionMethodBuilder >> slotNameDisplayName [
	^ (self slotName ifNil: [ '<missing>' ]) printString
]

{ #category : #property }
LcsSlotDefintionMethodBuilder >> slotTypes [
	^ self properties at: 'slotTypes' ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #property }
LcsSlotDefintionMethodBuilder >> slotTypes: aCollection [
	self properties at: 'slotTypes' put: aCollection
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass class removeSelector: self slotDefinitionSelector ]
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> validatePropertiesIn: slotDefinition [
	self properties
		keysAndValuesDo: [ :key :value | 
			self
				validateProperty: key
				value: value
				in: slotDefinition ]
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> validateProperty: aProperty value: aValue in: slotDefinition [
	| actualValue |

	aProperty = 'addCollectionMemberType' ifTrue: [ 
		^ self assert: ((slotDefinition perform: #collectionMemberTypes) includes: aValue "asClass")].
	
	actualValue := slotDefinition perform: aProperty asSymbol.
	
	aProperty = 'slotTypes' ifTrue: [ 
		^ self assert: actualValue equals: (aValue collect: [ :each | each asClass ]) ].
	
	actualValue isClass ifTrue: [ self assert: actualValue equals: aValue asClass].

	"aProperty = 'codeSuperclass' ifTrue: [ 
		self assert: (slotDefinition perform: #codeSuperclass) equals: aValue asClass.
		^self ]."
		
	self assert: actualValue  equals: aValue
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
	super verifyCodeInstallation.
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
	super verifySlotModelUpdatesMadeByBuilder.
	self currentSystem isNil ifTrue: [ ^ self ].
	self assert: (self targetClass slotModel slotDefinitionNamed: self slotName) notNil
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> verifyUninstall [
	super verifyUninstall.
	self targetClass isNil ifTrue: [ ^ self ].
	self assert: (self targetClass class canUnderstand: self slotDefinitionSelector) not
]
