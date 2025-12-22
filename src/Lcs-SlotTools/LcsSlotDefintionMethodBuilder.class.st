Class {
	#name : 'LcsSlotDefintionMethodBuilder',
	#superclass : 'LcsSlotDetailBuilder',
	#instVars : [
		'pragmaSelector'
	],
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'instance  creation' }
LcsSlotDefintionMethodBuilder class >> newFrom: aSlotDefinitionBuilder [
	^ self new
		initializeFrom: aSlotDefinitionBuilder;
		yourself
]

{ #category : 'building' }
LcsSlotDefintionMethodBuilder >> _installCode [
	super _installCode.
	self addRefactoring: (
		RBAddMethodChange
			compile: self slotDefinitionSource
			in: self targetClass class
			classified: #'slot definitions') execute.
	self beCodeInstalled
]

{ #category : 'verification' }
LcsSlotDefintionMethodBuilder >> _verifyCodeInstallation [
	| slotDefinition |
	super _verifyCodeInstallation.
	self assert: (self targetClass class canUnderstand: self slotDefinitionSelector).
	slotDefinition := self targetClass perform: self slotDefinitionSelector asSymbol.
	self assert: slotDefinition class == self slotClass.
	
	self validatePropertiesIn: slotDefinition
]

{ #category : 'gt views' }
LcsSlotDefintionMethodBuilder >> addAssociationsToUmlModel: aUmlModel [
	super addAssociationsToUmlModel: aUmlModel.
	aUmlModel
			addAssociation: self slotName , 'SlotDefintion'
			from: self targetClassName
			to: self slotClass.
	self targetClass isNil ifTrue: [ ^ self ].
	(self propertyAt: 'collectionSlotName') isNil ifTrue: [ ^ self ].
	aUmlModel
		addAssociation: (self propertyAt: 'collectionSlotName')
			from: self targetClassName
			to: self domainCollectionClass;
		addAssociation: self selectionPath
			from: self domainCollectionClass
			to: self domainCollectionElementClass
]

{ #category : 'gt views' }
LcsSlotDefintionMethodBuilder >> addClassesToUmlModel: umlModel [
	super addClassesToUmlModel: umlModel.
	umlModel
		addClassNamed: self targetClassName;
		addClassNamed: self slotClass.
	self targetClass isNil ifTrue: [ ^ self ].
	(self propertyAt: 'collectionSlotName') notNil
		ifTrue: [ self addDomainCollectionClassTo: umlModel ].
	self slotTypes notEmpty
		ifTrue: [ umlModel addClassNamed: self domainCollectionElementClass ]
]

{ #category : 'gt views' }
LcsSlotDefintionMethodBuilder >> addDomainCollectionClassTo: umlModel [
	umlModel addClass: self domainCollectionClass
]

{ #category : 'initialize\t' }
LcsSlotDefintionMethodBuilder >> addProperty: aPropertyName value: anObject [
	(self isValueOfSlotTemplateProperty: aPropertyName sameAs: anObject)
		ifFalse: [ self properties at: aPropertyName put: anObject ]
]

{ #category : 'gt views' }
LcsSlotDefintionMethodBuilder >> addRefactoringTextDetailsTo: aStream [
	aStream 
		nextPutAll: (self targetClassName ifNil: [ '<missing target class name>']); 
		nextPutAll:' class >>';
		nextPutAll: self slotDefinitionSource
]

{ #category : 'gt views' }
LcsSlotDefintionMethodBuilder >> addSlotAssociationsToUmlModel: aUmlModel [ 
	(aUmlModel classModelForClassname: self targetClassName)
		addAssociation: self slotDefinitionSelector toModelNamed: self slotClass.
	(aUmlModel classModelForClassname: self targetClassName)
		addAssociation: (self propertyAt: 'collectionSlotName') toModelNamed: self domainCollectionClass.
	(aUmlModel classModelForClassname: self domainCollectionClass)
		addAssociation: self selectionPath toModelNamed: self domainCollectionElementClass.
		
	"(aUmlModel classModelForClassname: self parentClassName)
		addAssociation: self slotName toModelNamed: self collectionClassName.
	(aUmlModel classModelForClassname: self collectionClassName)
		addAssociation: 'parent' toModelNamed: self parentClassName"
]

{ #category : 'gt views' }
LcsSlotDefintionMethodBuilder >> addSlotClassesToUmlModel: umlModel [
	umlModel
		addClassNamed: self targetClassName;
		addClassModel: self slotClass.
	(self propertyAt: 'collectionSlotName') notNil
		ifTrue: [ self addDomainCollectionClassTo: umlModel ].
	self slotTypes notEmpty
		ifTrue: [ umlModel addClassNamed: self domainCollectionElementClass ]
]

{ #category : 'configuration' }
LcsSlotDefintionMethodBuilder >> addSlotType: aClassorClassName [
	| aClassName |
	aClassName := aClassorClassName isClass 
					ifTrue: [ aClassorClassName name asString]
					ifFalse: [ aClassorClassName ].
	(self slotTypes includes: aClassorClassName) ifFalse: [ 
		self slotTypes add: aClassName ]
]

{ #category : 'code generation' }
LcsSlotDefintionMethodBuilder >> addValidationCondition: aStringBlock description: aDescription [
	self validationConditions addValidationCondition: aStringBlock description: aDescription
]

{ #category : 'accessing' }
LcsSlotDefintionMethodBuilder >> allowNil [
	^ self properties at: 'allowNil' ifAbsentPut: [ false ]
]

{ #category : 'accessing' }
LcsSlotDefintionMethodBuilder >> allowNil: aBoolean [
	self properties at: 'allowNil' put: aBoolean
]

{ #category : 'command' }
LcsSlotDefintionMethodBuilder >> beFacadeSlot [
	self pragmaSelector: 'facadeSlotDefinition'
]

{ #category : 'command' }
LcsSlotDefintionMethodBuilder >> beVirtualSlot [
	self pragmaSelector: 'virtualSlotDefinition'
]

{ #category : 'verification' }
LcsSlotDefintionMethodBuilder >> defaultCollectionMemberTypes [
	^ self slotClass new collectionMemberTypes
		collect: [ :each | each isClass ifTrue: [ each ] ifFalse: [ each asClass ] ]
]

{ #category : 'verification' }
LcsSlotDefintionMethodBuilder >> defaultSlotTypes [
	^ self slotClass new slotTypes
		collect: [ :each | each isClass ifTrue: [ each ] ifFalse: [ each asClass ] ]
]

{ #category : 'gt views' }
LcsSlotDefintionMethodBuilder >> derivedSlotName [
	^ self rawDerivedSlotName ifNil: [ '<missing slotName>' ]
]

{ #category : 'gt views' }
LcsSlotDefintionMethodBuilder >> domainCollectionClass [
	^ (self targetClass
		perform: ((self propertyAt: 'collectionSlotName') , 'SlotDefinition') asSymbol)
		slotTypes first
]

{ #category : 'gt views' }
LcsSlotDefintionMethodBuilder >> domainCollectionElementClass [
	^ self slotTypes first
]

{ #category : 'gt views' }
LcsSlotDefintionMethodBuilder >> gtClassViewOn: aView [
	<gtView>
	self targetClassName isNil ifTrue: [
		^ aView text
			title: 'No Target Class';
			priority: 200;
			text: 'No target class';
			actionUpdateButton ].
	^ super gtClassViewOn: aView
]

{ #category : 'gt views' }
LcsSlotDefintionMethodBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ];
		actionUpdateButton
]

{ #category : 'gt views' }
LcsSlotDefintionMethodBuilder >> gtSlotDefinitionImplementorFor: aView [
	<gtView>
	self targetClassName isNil ifTrue: [ ^ aView empty ].
	^ aView explicit
		title: 'Implementor(Slot Definition)';
		priority: 200;
		stencil: [  
			self targetClassName gtClassMatches &
			self slotDefinitionSelector gtImplementors  ]
]

{ #category : 'testing' }
LcsSlotDefintionMethodBuilder >> hasNoSlotTypes [
	^ self slotTypes isEmpty and: [ self slotDefinitionClassHasNoSlotTypes ]
]

{ #category : 'initialize' }
LcsSlotDefintionMethodBuilder >> initialize [
	super initialize.
	self pragmaSelector: 'slotDefinition'
]

{ #category : 'instance  creation' }
LcsSlotDefintionMethodBuilder >> initializeFrom: aSlotDefinitionBuilder [ 
	self 
		slotClass: aSlotDefinitionBuilder slotClassName asClass;
		slotTemplate: self slotClass new;
		targetClassName: aSlotDefinitionBuilder targetClassName.
	aSlotDefinitionBuilder addPropertiesTo: self
]

{ #category : 'initialize\t' }
LcsSlotDefintionMethodBuilder >> isValueOfSlotTemplateProperty: aPropertyName sameAs: anObject [
	| templateValue |
	templateValue := self valueOfSlotTemplateProperty: aPropertyName.
	templateValue isBlock ifTrue: [ ^ templateValue  asString = anObject asString].
	^ templateValue = anObject
]

{ #category : 'printing' }
LcsSlotDefintionMethodBuilder >> jobStepActionDescription [
	^ 'Install slot definition for'
]

{ #category : 'accessing' }
LcsSlotDefintionMethodBuilder >> pragmaSelector [
	^ pragmaSelector
]

{ #category : 'accessing' }
LcsSlotDefintionMethodBuilder >> pragmaSelector: aString [
	pragmaSelector := aString
]

{ #category : 'properties' }
LcsSlotDefintionMethodBuilder >> propertyAt: aName [
	^ self properties at: aName ifAbsent: [ nil ]
]

{ #category : 'properties' }
LcsSlotDefintionMethodBuilder >> propertyAt: aName ifAbsentPut: aBlock [ 
	self properties at: aName ifAbsentPut: aBlock
]

{ #category : 'properties' }
LcsSlotDefintionMethodBuilder >> propogateProperty: aName valueChangedTo: anObject [
	(self respondsTo: (aName , ':' asSymbol))
		ifTrue: [ 
			self perform: (aName , ':' asSymbol) with: anObject.
			^ self ]. 

	self propertyAt: aName put: anObject
]

{ #category : 'accessing' }
LcsSlotDefintionMethodBuilder >> required [
	^ self properties at: 'required' ifAbsentPut: [ false ]
]

{ #category : 'accessing' }
LcsSlotDefintionMethodBuilder >> required: aBoolean [
	self properties at: 'required' put: aBoolean
]

{ #category : 'gt views' }
LcsSlotDefintionMethodBuilder >> selectionPath [
	| targetPathStream |
	targetPathStream := WriteStream on: String new.
	(self propertyAt: 'targetSlotPath') do: [ :eachSlotName | targetPathStream nextPutAll: eachSlotName ] separatedBy: [ targetPathStream space ].
	targetPathStream nextPutAll: ' = '; nextPutAll: (self propertyAt: 'targetItem') printString.
	^ targetPathStream contents

]

{ #category : 'testing' }
LcsSlotDefintionMethodBuilder >> slotDefinitionClassHasNoSlotTypes [
	^ self slotClass notNil
		and: [ self slotClass new slotTypes isEmpty ]
]

{ #category : 'code generation' }
LcsSlotDefintionMethodBuilder >> slotDefinitionSelector [
	^ self rawDerivedSlotName 
		ifNil: [ LcsError signal: 'slotName is undefined' ]
		ifNotNil: [:name | (name , 'SlotDefinition') asSymbol ]
]

{ #category : 'code generation' }
LcsSlotDefintionMethodBuilder >> slotDefinitionSource [
	^ (LcsSlotDefinitionMethodFormatter newOnSlotDefinitionMethodBuilder: self)
		methodSource
]

{ #category : 'code generation' }
LcsSlotDefintionMethodBuilder >> slotNameDisplayString [
	^ self derivedSlotName
]

{ #category : 'property' }
LcsSlotDefintionMethodBuilder >> slotTypes [
	^ self properties at: 'slotTypes' ifAbsentPut: [ OrderedCollection new ]
]

{ #category : 'property' }
LcsSlotDefintionMethodBuilder >> slotTypes: aCollection [
	self properties at: 'slotTypes' put: aCollection
]

{ #category : 'gt views' }
LcsSlotDefintionMethodBuilder >> slotUmlModel [
	| umlModel |
	umlModel := LcsUmlModel new.
	self addSlotClassesToUmlModel: umlModel.
	umlModel removeDuplicates.
	self addSlotAssociationsToUmlModel: umlModel.
	umlModel resolveClassModelNames.
	^ umlModel
]

{ #category : 'gt views' }
LcsSlotDefintionMethodBuilder >> umlModel [
	^ super umlModel
]

{ #category : 'verification' }
LcsSlotDefintionMethodBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ 
		[self targetClass class removeSelector: self slotDefinitionSelector ] 
			on: LcsError 
			do: [ :s | s return: nil] ]
]

{ #category : 'verification' }
LcsSlotDefintionMethodBuilder >> validateCollectionMemberTypes: anExpectedCollection against: anActualCollection [
	self
		validateCollectionMemberTypes: anExpectedCollection
		against: anActualCollection
		defaultTypes: self defaultCollectionMemberTypes
]

{ #category : 'verification' }
LcsSlotDefintionMethodBuilder >> validateCollectionMemberTypes: anExpectedCollection against: anActualCollection defaultTypes: aDefaultCollection [
	| expected |
	expected := anExpectedCollection asOrderedCollection
			collect: [ :each | each isClass ifTrue: [ each ] ifFalse: [ each asClass ] ].
	expected size = anActualCollection size
		ifTrue: [ ^ self assert: anActualCollection equals: expected ].

	expected addAll: aDefaultCollection.
	self assert: expected size equals: anActualCollection size.
	self
		assert: (expected allSatisfy: [ :each | anActualCollection includes: each ])
]

{ #category : 'verification' }
LcsSlotDefintionMethodBuilder >> validatePostUpdateActions: enteredPostUpdateActions against: slotPostUpdateActions [
	self assert: slotPostUpdateActions collectionSize equals: enteredPostUpdateActions collectionSize.
	enteredPostUpdateActions
		do: [ :eachEnteredPostUpdateAction | 
			| slotPostUpdateAction |
			slotPostUpdateAction := slotPostUpdateActions actionWithDescription: eachEnteredPostUpdateAction description.
			self assert: slotPostUpdateAction notNil.
			self assert: eachEnteredPostUpdateAction description equals: slotPostUpdateAction description.
			self assert: eachEnteredPostUpdateAction actionBlock asString equals: slotPostUpdateAction actionBlock asString]
]

{ #category : 'verification' }
LcsSlotDefintionMethodBuilder >> validatePropertiesIn: slotDefinition [
	self properties
		keysAndValuesDo: [ :key :value | 
			self
				validateProperty: key
				value: value
				in: slotDefinition ]
]

{ #category : 'verification' }
LcsSlotDefintionMethodBuilder >> validateProperty: aProperty value: aExpectedObject in: slotDefinition [
	| actualValue |
	actualValue := slotDefinition perform: aProperty asSymbol.

	aProperty = 'collectionMemberTypes' ifTrue: [
		 ^ self validateCollectionMemberTypes: aExpectedObject against: actualValue ].
		
	aProperty = 'slotTypes'
		ifTrue: [ ^ self validateSlotTypes: aExpectedObject against: actualValue ].
		
	aProperty = 'targetSlotPath'
		ifTrue: [ ^ self validateTargetSlotPath: aExpectedObject asOrderedCollection against: actualValue ].

	aProperty = 'validationConditions'
		ifTrue: [ ^ self validateValidationConditions: aExpectedObject against: actualValue ].

	aProperty = 'postUpdateActions'
		ifTrue: [ ^ self validatePostUpdateActions: aExpectedObject against: actualValue ].
		
	(actualValue isClass and: [ aExpectedObject isClass ])
		ifTrue: [ ^ self assert: actualValue name equals: aExpectedObject name ].
		
	actualValue isClass
		ifTrue: [ ^ self assert: actualValue equals: aExpectedObject asClass ].

	actualValue isBlock 
		ifTrue: [ ^ self assert: actualValue asString equals: aExpectedObject asString].
		
	self assert: actualValue equals: aExpectedObject
]

{ #category : 'verification' }
LcsSlotDefintionMethodBuilder >> validateSlotTypes: anExpectedCollection against: anActualCollection [
	self
		validateCollectionMemberTypes: anExpectedCollection
		against: anActualCollection
		defaultTypes: self defaultSlotTypes
]

{ #category : 'verification' }
LcsSlotDefintionMethodBuilder >> validateTargetSlotPath: anExpectedCollection against: anActualCollection [
	self
		assert: anExpectedCollection
		equals: anActualCollection
]

{ #category : 'verification' }
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

{ #category : 'accessing' }
LcsSlotDefintionMethodBuilder >> validationConditions [
	^ self properties at: #validationConditions ifAbsentPut: [ LcsValidationConditions newOn: self ]
]

{ #category : 'accessing' }
LcsSlotDefintionMethodBuilder >> validationConditions: aCollection [
	self properties at: 'validationConditions' put: aCollection
]

{ #category : 'slot template' }
LcsSlotDefintionMethodBuilder >> valueOfSlotTemplateProperty: aKey [
	^ self slotTemplate properties at: aKey ifAbsent: [ ]
]

{ #category : 'verification' }
LcsSlotDefintionMethodBuilder >> verifySlotModelUpdatesMadeByBuilder [
	super verifySlotModelUpdatesMadeByBuilder.
	self currentSystem isNil ifTrue: [ ^ self ].
	self assert: self targetClass slotModel notNil.
	self assert: (self targetClass slotModel slotDefinitionNamed: self derivedSlotName) notNil
]

{ #category : 'verification' }
LcsSlotDefintionMethodBuilder >> verifyUninstall [
	| selector |
	super verifyUninstall.
	self targetClass isNil ifTrue: [ ^ self ].
	selector := [ self slotDefinitionSelector ] on: LcsError do: [ :s | ^ self ].
	self assert: (self targetClass class canUnderstand: selector) not
]
