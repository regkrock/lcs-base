Class {
	#name : 'LcsSlotDefinitionMethodBuilder',
	#superclass : 'LcsSlotDetailBuilder',
	#instVars : [
		'pragmaSelector'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'instance  creation' }
LcsSlotDefinitionMethodBuilder class >> newFrom: aSlotDefinitionBuilder [
	^ self new
		initializeFrom: aSlotDefinitionBuilder;
		yourself
]

{ #category : 'building' }
LcsSlotDefinitionMethodBuilder >> _installCode [
	super _installCode.
	self addRefactoring: (
		RBAddMethodChange
			compile: self slotDefinitionSource
			in: self targetClass class
			classified: #'slot definitions') execute.
	self beCodeInstalled
]

{ #category : 'verification' }
LcsSlotDefinitionMethodBuilder >> _verifyCodeInstallation [
	| slotDefinition |
	super _verifyCodeInstallation.
	self assert: (self targetClass class canUnderstand: self slotDefinitionSelector).
	slotDefinition := self targetClass perform: self slotDefinitionSelector asSymbol.
	self assert: slotDefinition class == self slotClass.
	
	self validatePropertiesIn: slotDefinition
]

{ #category : 'gt views' }
LcsSlotDefinitionMethodBuilder >> addAssociationsToUmlModel: aUmlModel [
	super addAssociationsToUmlModel: aUmlModel.
	aUmlModel
			addAssociation: self derivedSlotName , 'SlotDefinition'
			from: self targetClassName
			to: self slotClass.
	self targetClass isNil ifTrue: [ ^ self ].
	(self propertyAt: 'collectionSlotName') isNil ifTrue: [ ^ self ].
	aUmlModel
		addAssociation: self selectionPath
		"(self propertyAt: 'collectionSlotName')"
			from: self targetClassName
			to: self domainCollectionClass;
		addAssociation: '0:m'
			from: self domainCollectionClass
			to: self domainCollectionElementClass
]

{ #category : 'gt views' }
LcsSlotDefinitionMethodBuilder >> addClassesToUmlModel: umlModel [
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
LcsSlotDefinitionMethodBuilder >> addDomainCollectionClassTo: umlModel [
	umlModel addClass: self domainCollectionClass
]

{ #category : 'initialize\t' }
LcsSlotDefinitionMethodBuilder >> addProperty: aPropertyName value: anObject [
	(self isValueOfSlotTemplateProperty: aPropertyName sameAs: anObject)
		ifFalse: [ self properties at: aPropertyName put: anObject ]
]

{ #category : 'gt views' }
LcsSlotDefinitionMethodBuilder >> addRefactoringTextDetailsTo: aStream [
	aStream 
		nextPutAll: (self targetClassName ifNil: [ '<missing target class name>']); 
		nextPutAll:' class >>';
		nextPutAll: self slotDefinitionSource
]

{ #category : 'gt views' }
LcsSlotDefinitionMethodBuilder >> addSlotAssociationsToUmlModel: aUmlModel [ 
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
LcsSlotDefinitionMethodBuilder >> addSlotClassesToUmlModel: umlModel [
	umlModel
		addClassNamed: self targetClassName;
		addClassModel: self slotClass.
	(self propertyAt: 'collectionSlotName') notNil
		ifTrue: [ self addDomainCollectionClassTo: umlModel ].
	self slotTypes notEmpty
		ifTrue: [ umlModel addClassNamed: self domainCollectionElementClass ]
]

{ #category : 'configuration' }
LcsSlotDefinitionMethodBuilder >> addSlotType: aClassorClassName [
	| aClassName |
	aClassName := aClassorClassName isClass 
					ifTrue: [ aClassorClassName name asString]
					ifFalse: [ aClassorClassName ].
	(self slotTypes includes: aClassorClassName) ifFalse: [ 
		self slotTypes add: aClassName ]
]

{ #category : 'code generation' }
LcsSlotDefinitionMethodBuilder >> addValidationCondition: aStringBlock description: aDescription [
	self validationConditions addValidationCondition: aStringBlock description: aDescription
]

{ #category : 'accessing' }
LcsSlotDefinitionMethodBuilder >> allowNil [
	^ self properties at: 'allowNil' ifAbsentPut: [ false ]
]

{ #category : 'accessing' }
LcsSlotDefinitionMethodBuilder >> allowNil: aBoolean [
	self properties at: 'allowNil' put: aBoolean
]

{ #category : 'command' }
LcsSlotDefinitionMethodBuilder >> beCollectionItemSlot [
	self pragmaSelector: LcsBaseSlot collectionItemSlotDefinitionName
]

{ #category : 'command' }
LcsSlotDefinitionMethodBuilder >> beFacadeSlot [
	self pragmaSelector: LcsBaseSlot facadeSlotDefinitionName
]

{ #category : 'command' }
LcsSlotDefinitionMethodBuilder >> beVirtualSlot [
	self pragmaSelector: LcsBaseSlot virtualSlotDefinitionName
]

{ #category : 'verification' }
LcsSlotDefinitionMethodBuilder >> defaultCollectionMemberTypes [
	^ self slotClass new collectionMemberTypes
		collect: [ :each | each isClass ifTrue: [ each ] ifFalse: [ each asClass ] ]
]

{ #category : 'verification' }
LcsSlotDefinitionMethodBuilder >> defaultSlotTypes [
	^ self slotClass new slotTypes
		collect: [ :each | each isClass ifTrue: [ each ] ifFalse: [ each asClass ] ]
]

{ #category : 'gt views' }
LcsSlotDefinitionMethodBuilder >> derivedSlotName [
	^ self rawDerivedSlotName ifNil: [ '<missing slotName>' ]
]

{ #category : 'gt views' }
LcsSlotDefinitionMethodBuilder >> domainCollectionClass [
	^ (self targetClass
		perform: ((self propertyAt: 'collectionSlotName') , 'SlotDefinition') asSymbol)
		slotTypes first
]

{ #category : 'gt views' }
LcsSlotDefinitionMethodBuilder >> domainCollectionElementClass [
	^ self slotTypes first
]

{ #category : 'gt views' }
LcsSlotDefinitionMethodBuilder >> gtClassViewOn: aView [
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
LcsSlotDefinitionMethodBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ];
		actionUpdateButton
]

{ #category : 'gt views' }
LcsSlotDefinitionMethodBuilder >> gtSlotDefinitionImplementorFor: aView [
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
LcsSlotDefinitionMethodBuilder >> hasNoSlotTypes [
	^ self slotTypes isEmpty and: [ self slotDefinitionClassHasNoSlotTypes ]
]

{ #category : 'initialize' }
LcsSlotDefinitionMethodBuilder >> initialize [
	super initialize.
	self pragmaSelector: LcsBaseSlot accessorSlotDefinitionName
]

{ #category : 'instance  creation' }
LcsSlotDefinitionMethodBuilder >> initializeFrom: aSlotDefinitionBuilder [ 
	self 
		slotClass: aSlotDefinitionBuilder slotClassName asClass;
		slotTemplate: self slotClass new;
		targetClassName: aSlotDefinitionBuilder targetClassName.
	aSlotDefinitionBuilder addPropertiesTo: self
]

{ #category : 'initialize\t' }
LcsSlotDefinitionMethodBuilder >> isValueOfSlotTemplateProperty: aPropertyName sameAs: anObject [
	| templateValue |
	templateValue := self valueOfSlotTemplateProperty: aPropertyName.
	templateValue isBlock ifTrue: [ ^ templateValue  asString = anObject asString].
	^ templateValue = anObject
]

{ #category : 'printing' }
LcsSlotDefinitionMethodBuilder >> jobStepActionDescription [
	^ 'Install slot definition for'
]

{ #category : 'accessing' }
LcsSlotDefinitionMethodBuilder >> pragmaSelector [
	^ pragmaSelector
]

{ #category : 'accessing' }
LcsSlotDefinitionMethodBuilder >> pragmaSelector: aString [
	pragmaSelector := aString
]

{ #category : 'properties' }
LcsSlotDefinitionMethodBuilder >> propertyAt: aName [
	^ self properties at: aName ifAbsent: [ nil ]
]

{ #category : 'properties' }
LcsSlotDefinitionMethodBuilder >> propertyAt: aName ifAbsentPut: aBlock [ 
	self properties at: aName ifAbsentPut: aBlock
]

{ #category : 'properties' }
LcsSlotDefinitionMethodBuilder >> propogateProperty: aName valueChangedTo: anObject [
	(self respondsTo: (aName , ':' asSymbol))
		ifTrue: [ 
			self perform: (aName , ':' asSymbol) with: anObject.
			^ self ]. 

	self propertyAt: aName put: anObject
]

{ #category : 'accessing' }
LcsSlotDefinitionMethodBuilder >> required [
	^ self properties at: 'required' ifAbsentPut: [ false ]
]

{ #category : 'accessing' }
LcsSlotDefinitionMethodBuilder >> required: aBoolean [
	self properties at: 'required' put: aBoolean
]

{ #category : 'gt views' }
LcsSlotDefinitionMethodBuilder >> selectionPath [
	| targetPathStream |
	targetPathStream := WriteStream on: String new.
	targetPathStream nextPutAll: self derivedSlotName; cr.
	(self propertyAt: 'targetSlotPath') do: [ :eachSlotName | targetPathStream nextPutAll: eachSlotName ] separatedBy: [ targetPathStream space ].
	targetPathStream nextPutAll: ' = '; nextPutAll: (self propertyAt: 'targetItem') printString.
	^ targetPathStream contents

]

{ #category : 'testing' }
LcsSlotDefinitionMethodBuilder >> slotDefinitionClassHasNoSlotTypes [
	^ self slotClass notNil
		and: [ self slotClass new slotTypes isEmpty ]
]

{ #category : 'code generation' }
LcsSlotDefinitionMethodBuilder >> slotDefinitionSelector [
	^ self rawDerivedSlotName 
		ifNil: [ LcsError signal: 'slotName is undefined' ]
		ifNotNil: [:name | (name , 'SlotDefinition') asSymbol ]
]

{ #category : 'code generation' }
LcsSlotDefinitionMethodBuilder >> slotDefinitionSource [
	^ (LcsSlotDefinitionMethodFormatter newOnSlotDefinitionMethodBuilder: self)
		methodSource
]

{ #category : 'code generation' }
LcsSlotDefinitionMethodBuilder >> slotNameDisplayString [
	^ self derivedSlotName
]

{ #category : 'property' }
LcsSlotDefinitionMethodBuilder >> slotTypes [
	^ self properties at: 'slotTypes' ifAbsentPut: [ OrderedCollection new ]
]

{ #category : 'property' }
LcsSlotDefinitionMethodBuilder >> slotTypes: aCollection [
	self properties at: 'slotTypes' put: aCollection
]

{ #category : 'gt views' }
LcsSlotDefinitionMethodBuilder >> slotUmlModel [
	| umlModel |
	umlModel := LcsUmlModel new.
	self addSlotClassesToUmlModel: umlModel.
	umlModel removeDuplicates.
	self addSlotAssociationsToUmlModel: umlModel.
	umlModel resolveClassModelNames.
	^ umlModel
]

{ #category : 'gt views' }
LcsSlotDefinitionMethodBuilder >> umlModel [
	^ super umlModel
]

{ #category : 'verification' }
LcsSlotDefinitionMethodBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ 
		[self targetClass class removeSelector: self slotDefinitionSelector ] 
			on: LcsError 
			do: [ :s | s return: nil] ]
]

{ #category : 'verification' }
LcsSlotDefinitionMethodBuilder >> validateCollectionMemberTypes: anExpectedCollection against: anActualCollection [
	self
		validateCollectionMemberTypes: anExpectedCollection
		against: anActualCollection
		defaultTypes: self defaultCollectionMemberTypes
]

{ #category : 'verification' }
LcsSlotDefinitionMethodBuilder >> validateCollectionMemberTypes: anExpectedCollection against: anActualCollection defaultTypes: aDefaultCollection [
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
LcsSlotDefinitionMethodBuilder >> validatePostUpdateActions: enteredPostUpdateActions against: slotPostUpdateActions [
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
LcsSlotDefinitionMethodBuilder >> validatePropertiesIn: slotDefinition [
	self properties
		keysAndValuesDo: [ :key :value | 
			self
				validateProperty: key
				value: value
				in: slotDefinition ]
]

{ #category : 'verification' }
LcsSlotDefinitionMethodBuilder >> validateProperty: aProperty value: aExpectedObject in: slotDefinition [
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
LcsSlotDefinitionMethodBuilder >> validateSlotTypes: anExpectedCollection against: anActualCollection [
	self
		validateCollectionMemberTypes: anExpectedCollection
		against: anActualCollection
		defaultTypes: self defaultSlotTypes
]

{ #category : 'verification' }
LcsSlotDefinitionMethodBuilder >> validateTargetSlotPath: anExpectedCollection against: anActualCollection [
	self
		assert: anExpectedCollection
		equals: anActualCollection
]

{ #category : 'verification' }
LcsSlotDefinitionMethodBuilder >> validateValidationConditions: aValidationConditions against: actualValidationConditions [
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
LcsSlotDefinitionMethodBuilder >> validationConditions [
	^ self properties at: #validationConditions ifAbsentPut: [ LcsValidationConditions newOn: self ]
]

{ #category : 'accessing' }
LcsSlotDefinitionMethodBuilder >> validationConditions: aCollection [
	self properties at: 'validationConditions' put: aCollection
]

{ #category : 'slot template' }
LcsSlotDefinitionMethodBuilder >> valueOfSlotTemplateProperty: aKey [
	^ self slotTemplate properties at: aKey ifAbsent: [ ]
]

{ #category : 'verification' }
LcsSlotDefinitionMethodBuilder >> verifySlotModelUpdatesMadeByBuilder [
	super verifySlotModelUpdatesMadeByBuilder.
	self currentSystem isNil ifTrue: [ ^ self ].
	self assert: self targetClass slotModel notNil.
	self assert: (self targetClass slotModel slotDefinitionNamed: self derivedSlotName) notNil
]

{ #category : 'verification' }
LcsSlotDefinitionMethodBuilder >> verifyUninstall [
	| selector |
	super verifyUninstall.
	self targetClass isNil ifTrue: [ ^ self ].
	selector := [ self slotDefinitionSelector ] on: LcsError do: [ :s | ^ self ].
	self assert: (self targetClass class canUnderstand: selector) not
]
