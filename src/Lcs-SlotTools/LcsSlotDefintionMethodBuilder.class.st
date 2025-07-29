Class {
	#name : #LcsSlotDefintionMethodBuilder,
	#superclass : #LcsSlotDetailBuilder,
	#instVars : [
		'slotClass',
		'slotTemplate'
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
	(self slotTemplate isChangedProperty: aPropertyName value: aValue) ifFalse: [ ^ self ].

	(#('slotTypes' 'collectionMemberTypes') includes: aPropertyName) ifTrue: [ 
		^ self addSlotTypesKeyword: aPropertyName argument: aValue to: aCodeStream ].

	aPropertyName = 'validationConditions' ifTrue: [ 
		^ self addValidationConditionsKeyword: aPropertyName argument: aValue to: aCodeStream ].		
		
	aValue isString
		ifFalse: [ ^ aCodeStream addKeyword: aPropertyName argument: aValue asString ].

	(self classFor: aValue) notNil
		ifTrue: [ ^ aCodeStream addKeyword: aPropertyName argument: aValue ].

	aCodeStream addKeyword: aPropertyName argument: aValue printString
]

{ #category : #'initialize\t' }
LcsSlotDefintionMethodBuilder >> addProperty: aPropertyName value: anObject [
	(self isValueOfSlotTemplateProperty: aPropertyName sameAs: anObject)
		ifFalse: [ self properties at: aPropertyName put: anObject ]
]

{ #category : #'gt views' }
LcsSlotDefintionMethodBuilder >> addRefactoringTextDetailsTo: aStream [
	aStream 
		nextPutAll: (self targetClassName ifNil: [ '<missing target class name>']); 
		nextPutAll:' class >>';
		nextPutAll: self slotDefinitionSource
]

{ #category : #'gt views' }
LcsSlotDefintionMethodBuilder >> addSlotAssociationsToUmlModel: umlModel [ 
	"(umlModel classModelForClassname: self parentClassName)
		addAssociation: self slotName toModelNamed: self collectionClassName.
	(umlModel classModelForClassname: self collectionClassName)
		addAssociation: 'parent' toModelNamed: self parentClassName"
]

{ #category : #'gt views' }
LcsSlotDefintionMethodBuilder >> addSlotClassesToUmlModel: umlModel [ 
	"umlModel 
		addClassNamed: self targetClassName;
		addClassModelForExisting: LcsSlotModel;
		addClassModelForExisting: self slotClass "
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
	aValue do: [ :eachClassName | slotTypesCollectionCreationStream nextPutAll: ' with: ' , eachClassName asString ].
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
	self validationConditions addValidationCondition: aStringBlock description: aDescription
]

{ #category : #'code generation' }
LcsSlotDefintionMethodBuilder >> addValidationConditionsKeyword: aPropertyName argument: aValidationConditions to: aCodeStream [

	aValidationConditions hasElements ifFalse: [ ^ self ].

	aValidationConditions do: [ :each |
		aCodeStream
			addKeyword: 'addValidationCondition'
			argument: each conditionBlock printString
			keyword: 'description'
			argument: each validationDescription printString  ]
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> allowNil [
	^ self properties at: 'allowNil' ifAbsentPut: [ false ]
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> allowNil: aBoolean [
	self properties at: 'allowNil' put: aBoolean
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> defaultSlotTypes [
	^ self slotClass new slotTypes
		collect: [ :each | each isClass ifTrue: [ each ] ifFalse: [ each asClass ] ]
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

{ #category : #'gt views' }
LcsSlotDefintionMethodBuilder >> gtUMLFor: aView [
	<gtView>
	^ aView mondrian
		title: 'UML';
		priority: 20;
		initialize: (self proposedUmlModelFor: self slotUmlModel);
		actionUpdateButton
]

{ #category : #testing }
LcsSlotDefintionMethodBuilder >> hasNoSlotTypes [
	^ self slotTypes isEmpty and: [ self slotDefinitionClassHasNoSlotTypes ]
]

{ #category : #'instance  creation' }
LcsSlotDefintionMethodBuilder >> initializeFrom: aSlotDefinitionBuilder [ 
	self 
		slotClass: aSlotDefinitionBuilder slotClassName asClass;
		slotTemplate: self slotClass new;
		targetClassName: aSlotDefinitionBuilder targetClassName.
	aSlotDefinitionBuilder addPropertiesTo: self
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

{ #category : #'initialize\t' }
LcsSlotDefintionMethodBuilder >> isValueOfSlotTemplateProperty: aPropertyName sameAs: anObject [
	| templateValue |
	templateValue := self valueOfSlotTemplateProperty: aPropertyName.
	templateValue isBlock ifTrue: [ ^ templateValue  asString = anObject asString].
	^ templateValue = anObject
]

{ #category : #printing }
LcsSlotDefintionMethodBuilder >> jobStepActionDescription [
	^ 'Install slot definition for'
]

{ #category : #properties }
LcsSlotDefintionMethodBuilder >> propertyAt: aName ifAbsentPut: aBlock [ 
	self properties at: aName ifAbsentPut: aBlock
]

{ #category : #properties }
LcsSlotDefintionMethodBuilder >> propogateProperty: aName valueChangedTo: anObject [
	(self respondsTo: (aName , ':' asSymbol))
		ifTrue: [ 
			self perform: (aName , ':' asSymbol) with: anObject.
			^ self ]. 

	self propertyAt: aName put: anObject
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
LcsSlotDefintionMethodBuilder >> slotClass [
	^ slotClass
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> slotClass: anObject [
	slotClass := anObject
]

{ #category : #testing }
LcsSlotDefintionMethodBuilder >> slotDefinitionClassHasNoSlotTypes [
	^ self slotClass notNil
		and: [ self slotClass new slotTypes isEmpty ]
]

{ #category : #'code generation' }
LcsSlotDefintionMethodBuilder >> slotDefinitionClassNameDisplayName [
	^ self slotClass
		ifNil: [ '<missing>' ]
		ifNotNil: [ :class | class name ]
]

{ #category : #'code generation' }
LcsSlotDefintionMethodBuilder >> slotDefinitionSelector [
	self slotName ifNotNil: [:s | ^ (s , 'SlotDefinition') asSymbol ].
	self slotTemplate ifNil: [ ^ LcsError signal: 'slotName is undefined' ].
	self slotTemplate slotName ifNotNil: [ :s | ^ (s , 'SlotDefinition') asSymbol ].
	LcsError signal: 'slotName is undefined'
]

{ #category : #'code generation' }
LcsSlotDefintionMethodBuilder >> slotDefinitionSource [
	| codeStream |
	codeStream := LcsMethodStream new.
	codeStream
		startSlotDefintionSource: self slotDefinitionSelector;
		addSlotDefinitionClassCreatonLine: self slotDefinitionClassNameDisplayName.

	self properties keysAndValuesDo: [ :eachPropertyName :eachValue |
		self addKeyword: eachPropertyName argument: eachValue to: codeStream].

	codeStream addYourself.

	^ codeStream contents
]

{ #category : #'code generation' }
LcsSlotDefintionMethodBuilder >> slotNameDisplayName [
	^ (self slotName ifNil: [ '<missing>' ]) printString
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> slotTemplate [
	^ slotTemplate ifNil: [ slotTemplate := self slotClass new ]
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> slotTemplate: anObject [
	slotTemplate := anObject
]

{ #category : #property }
LcsSlotDefintionMethodBuilder >> slotTypes [
	^ self properties at: 'slotTypes' ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #property }
LcsSlotDefintionMethodBuilder >> slotTypes: aCollection [
	self properties at: 'slotTypes' put: aCollection
]

{ #category : #'gt views' }
LcsSlotDefintionMethodBuilder >> slotUmlModel [
	| umlModel |
	umlModel := LcsUmlModel new.
	self addSlotClassesToUmlModel: umlModel.
	umlModel removeDuplicates.
	self addSlotAssociationsToUmlModel: umlModel.
	umlModel resolveClassModelNames.
	^ umlModel
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ 
		[self targetClass class removeSelector: self slotDefinitionSelector ] 
			on: LcsError 
			do: [ :s | s return: nil] ]
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

	actualValue := slotDefinition perform: aProperty asSymbol.

	aProperty = 'collectionMemberTypes' ifTrue: [
		^ self assert: actualValue  equals: (aValue collect: [ :each | each asClass ]) ].
		
	aProperty = 'slotTypes'
		ifTrue: [ ^ self validateSlotTypes: aValue against: actualValue ].

	aProperty = 'validationConditions'
		ifTrue: [ ^ self validateValidationConditions: aValue against: actualValue ].

	actualValue isClass
		ifTrue: [ ^ self assert: actualValue equals: aValue asClass ].

	actualValue isBlock 
		ifTrue: [ ^ self assert: actualValue asString equals: aValue asString].
		
	self assert: actualValue equals: aValue
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> validateSlotTypes: aCollection against: actualValue [
	| expected |
	expected := aCollection asOrderedCollection collect: [ :each | each asClass ].
	expected size = actualValue size
		ifTrue: [ ^ self assert: actualValue equals: expected ].
		
	expected addAll: self defaultSlotTypes.
	self assert: expected size equals: actualValue size.
	self assert: (expected allSatisfy: [ :each | actualValue includes: each ])
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> validateValidationConditions: aValidationConditions against: actualValidationConditions [
	self assert: actualValidationConditions collectionSize equals: aValidationConditions collectionSize.
	aValidationConditions
		do: [ :eachValidationCondition | 
			| actualValidationCondition |
			actualValidationCondition := actualValidationConditions validationConditionWithDescription: eachValidationCondition validationDescription.
			self assert: actualValidationCondition notNil.
			self assert: eachValidationCondition validationDescription equals: actualValidationCondition validationDescription.
			self assert: eachValidationCondition conditionBlock asString equals: actualValidationCondition conditionBlock asString]
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> validationConditions [
	^ self properties at: #validationConditions ifAbsentPut: [ LcsValidationConditions newOn: self ]
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilder >> validationConditions: aCollection [
	self properties at: 'validationConditions' put: aCollection
]

{ #category : #'slot template' }
LcsSlotDefintionMethodBuilder >> valueOfSlotTemplateProperty: aKey [
	^ self slotTemplate properties at: aKey ifAbsent: [ ]
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> verifyCodeInstallation [
	| slotDefinition |
	super verifyCodeInstallation.
	self assert: (self targetClass class canUnderstand: self slotDefinitionSelector).
	slotDefinition := self targetClass perform: self slotDefinitionSelector asSymbol.
	self assert: slotDefinition class == self slotClass.
	
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
	| selector |
	super verifyUninstall.
	self targetClass isNil ifTrue: [ ^ self ].
	selector := [ self slotDefinitionSelector ] on: LcsError do: [ :s | ^ self ].
	self assert: (self targetClass class canUnderstand: selector) not
]
