"
This class and its subclasses define a slot (instance variable or a GemStone dynamic instance variable)
Accessing and Updating the instance variable is done via the slot definition. It encapsulates the acutal slot (instance variable).

slotName - this is the name of the slot and is the same as the instvarName. 
parent -        this points to the parent of the slot defintion. This is normally an instance of LcsSlotModel.
slotTypes -  this is a collection of the class types that can be stored in the slot (instance variable).	
						 Ex: UndefinedObject - means a nil can be store here
						        LcsPerson - means that an instance of LcsPerson can be stored in the slot.
required -   The contents of this slot must be set rather than be left was being nil or null before the owning 
					    object can be persisted.
initialValueBlock - The slot will be initialized to evaluated value of this block when an instance of its associated
						class is created.  
validator - ?????
"
Class {
	#name : #LcsAccessorSlot,
	#superclass : #LcsBaseSlot,
	#instVars : [
		'validator',
		'variableUpdatePolicy',
		'postUpdateActions'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #configuration }
LcsAccessorSlot class >> domainObjectSlotBlockArguments [
	^ #('domainObject' 'slot')
]

{ #category : #testing }
LcsAccessorSlot class >> isAbstract [
	^ self name = #LcsAccessorSlot
]

{ #category : #testing }
LcsAccessorSlot class >> isAccessorSlot [
	^ true
]

{ #category : #querying }
LcsAccessorSlot class >> slotKind [
	^ 'accessor'
]

{ #category : #configuration }
LcsAccessorSlot class >> valueDomainObjectOldValueBlockArguments [
	^ #('value' 'domainObject' 'oldValue')
]

{ #category : #configuration }
LcsAccessorSlot class >> valueSlotBlockArguments [
	^ #('value' 'slot')
]

{ #category : #'slot model' }
LcsAccessorSlot >> _slotVarPut: anObject in: aDomainObject [
	self verifySlotType: anObject for: aDomainObject.
	self currentUnitOfWork
		setValueIn: aDomainObject
		slot: self
		to: anObject
]

{ #category : #'post update actions' }
LcsAccessorSlot >> addPostUpdateAction: anUpdateAction [
	self postUpdateActions addUpdateAction: anUpdateAction
]

{ #category : #'slot definitions' }
LcsAccessorSlot >> addSubclassesOf: aClass [
	aClass subclassesDo: [ :each | self addSlotType: each ] 
]

{ #category : #validation }
LcsAccessorSlot >> addValidateConfigurationResultTo: aValidator [
	(self domainClass allInstVarNames includes: self slotName)
		ifFalse: [ aValidator
				add: (LcsValidatorIssueMessage newOn: self message: self slotDoesNotExistMessage) ]
]

{ #category : #val }
LcsAccessorSlot >> addValidationCondition: aValidationCondition [
	self validationConditions addValidationCondition: aValidationCondition
]

{ #category : #validations }
LcsAccessorSlot >> addValidationCondition: aBlock description: aString [
	self validationConditions addValidationCondition: aBlock description: aString
]

{ #category : #properties }
LcsAccessorSlot >> allowNil [ 
	^ self propertyAt: 'allowNil'
]

{ #category : #properties }
LcsAccessorSlot >> allowNil: anObject [
	self propertyAt: 'allowNil' put: anObject
]

{ #category : #magritte }
LcsAccessorSlot >> allowNilDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Allow Nil';
		priority: 10;
		accessor: #'allowNil';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]

]

{ #category : #properties }
LcsAccessorSlot >> allowNull [
	^ self propertyAt: 'allowNull' ifAbsent: [ false ]
]

{ #category : #properties }
LcsAccessorSlot >> allowNull: aBoolean [
	^ self propertyAt: 'allowNull' ifAbsent: aBoolean
]

{ #category : #magritte }
LcsAccessorSlot >> allowNullDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Allow Null';
		priority: 10;
		accessor: #'allowNull';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]

]

{ #category : #converting }
LcsAccessorSlot >> asViewItem [
	^ LcsExtantSlotDefinitionViewItem on: self 
]

{ #category : #'slot model' }
LcsAccessorSlot >> assignParent: aDomainObject to: newValue [
	newValue isDomainObject ifTrue: [
		newValue parent: aDomainObject ]
]

{ #category : #validations }
LcsAccessorSlot >> audit: anObject withAuditor: anAuditor [
	| value |
	value := self currentSlotVarIn: anObject.
	[ self verifyType: value for: anObject ]
		on: LcsInvalidSlotTypeError
		do: [ :signal |
			anAuditor addErrorDescription: signal invalidAuditMessage.
			signal return: nil ].
	self validationConditions do: [ :eachCondition | 
		[ eachCondition cull: value cull: anObject ]
			on: LcsInvalidSlotTypeError
			do: [ :signal |
				anAuditor addErrorDescription: signal invalidAuditMessage.
				signal return: nil ] ]
]

{ #category : #configuration }
LcsAccessorSlot >> beAllowNil [ 
	self allowNil: true
]

{ #category : #configuration }
LcsAccessorSlot >> beOptional [
	self required: false
]

{ #category : #configuration }
LcsAccessorSlot >> beRequired [
	self required: true
]

{ #category : #'history saving' }
LcsAccessorSlot >> changeHistoryRepresentationIn: aNewObject [
	^ aNewObject isDomainObject ifTrue: [ aNewObject uuid ] ifFalse: [ aNewObject ]
]

{ #category : #testing }
LcsAccessorSlot >> changedSlotRecordFor: aDomainObject [
	^ self currentUnitOfWork
		changedSlotRecordFor: aDomainObject
		slotNamed: self slotName
]

{ #category : #defaults }
LcsAccessorSlot >> createNewInstanceOf: aClass inContext: context [
	aClass isDomainClass
		ifTrue: [ aClass newInContext: context ]
		ifFalse: [ aClass new ]
]

{ #category : #testing }
LcsAccessorSlot >> currentSlotVarIn: aDomainObject [
	^ (self changedSlotRecordFor: aDomainObject)
		ifNil: [ self persistedSlotVarIn: aDomainObject ]
		ifNotNil: [ :changedSlotRecord | changedSlotRecord newValue ]
]

{ #category : #defaults }
LcsAccessorSlot >> defaultInitialValueBlock [
	^ [ :domainObject :slot | 
		(slot slotTypes any new)
			parent: domainObject;
			yourself ]
]

{ #category : #printing }
LcsAccessorSlot >> defaultInitialValueBlockSourceCode [
	^ self defaultInitialValueBlock compiledBlock sourceNode sourceCode
]

{ #category : #defaults }
LcsAccessorSlot >> defaultPrevalidationTransformBlock [
	^ [ :value :slot | value ]
]

{ #category : #configuration }
LcsAccessorSlot >> domainObjectSlotBlockArguments [
	^ self class domainObjectSlotBlockArguments
]

{ #category : #'gt views' }
LcsAccessorSlot >> gtDomainMetaFor: aView [
	<gtView>
	self parent isNil ifTrue: [ ^ aView empty ].
	^ aView explicit
		title: 'Domain Meta';
		priority: 200;
		stencil: [ (GtCoderElement forObject: self domainClass) disablePlayPage beNormalLevel ]
]

{ #category : #'gt views' }
LcsAccessorSlot >> gtLiveFor: aView [
	^ (super gtLiveFor: aView)
		actionUpdateButton
]

{ #category : #'gt views' }
LcsAccessorSlot >> gtMagritteFor: aView [
	^ (super gtMagritteFor: aView)
		actionUpdateButton
]

{ #category : #'gt views' }
LcsAccessorSlot >> gtSlotModelFor: aView [
	<gtView>
	self parent ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Slot Model';
		priority: 200;
		object: [ self parent ];
		view: #gtRawFor:;
		yourself
]

{ #category : #'gt views' }
LcsAccessorSlot >> gtViewSlotModelChildren [
	^ {
		LcsSlotModelViewItem newLabel: 'domainClass' item: self domainClass.
		LcsSlotModelViewItem newLabel: 'slotName' item: self slotName.
		LcsSlotModelViewItem newLabel: 'slotTypes' item: self slotTypeClassNames.
		LcsSlotModelViewItem newLabel: 'required' item: self isRequired.
		}
]

{ #category : #properties }
LcsAccessorSlot >> initialValue [
	^ self initialValueBlock cull: nil cull: self
]

{ #category : #properties }
LcsAccessorSlot >> initialValue: anObject [
	self initialValueBlock: (self class evaluate: '[ :domainObject :slot | ' , anObject asString , ' ]')
]

{ #category : #properties }
LcsAccessorSlot >> initialValueBlock [
	^ self propertyAt: 'initialValueBlock'
]

{ #category : #properties }
LcsAccessorSlot >> initialValueBlock: aBlock [ 
	self propertyAt: 'initialValueBlock' put: aBlock
]

{ #category : #magritte }
LcsAccessorSlot >> initialValueBlockDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Initial Value Block [ :domainObject :slot | ';
		priority: 10;
		default: '';
		accessor: (LcsMABlockPluggableAccessor 
						accessors: #(#initialValueBlock )
						arguments: LcsAccessorSlot domainObjectSlotBlockArguments);
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : #'object initialization' }
LcsAccessorSlot >> initialValueFor: aDomainObject [
	| newValue |
	newValue := self initialValueBlock cull: aDomainObject cull: self.
	"(newValue isDomainObject and: [ self currentSystem notNil ])
		ifTrue: [ 
			self assignParent: aDomainObject to: newValue.
			self currentUnitOfWork addObject: newValue context: aDomainObject ]."
	^ newValue
]

{ #category : #initialize }
LcsAccessorSlot >> initialize [
	super initialize.
	self makeUpdateOfVariableViaUnitOfWork.
	self validationConditions: (LcsValidationConditions newOn: self).
	self postUpdateActions: (LcsUpdateActions newOn: self).
	self initialValueBlock: self defaultInitialValueBlock.
	self prevalidationTransformBlock: self defaultPrevalidationTransformBlock.
	self allowNil: false.
	self allowNull: false.
	self required: false.
]

{ #category : #'object initialization' }
LcsAccessorSlot >> initializeSlotValueIn: aDomainObject [
	self slotVarPut: (self initialValueFor: aDomainObject) in: aDomainObject
]

{ #category : #'object initialization' }
LcsAccessorSlot >> initializeUnintializedSlotValueIn: aDomainObject [
	(self currentSlotVarIn: aDomainObject) ifNotNil: [ ^ self ].
	self initializeSlotValueIn: aDomainObject
]

{ #category : #configuration }
LcsAccessorSlot >> initializeVariableUpdatePolicy [
	self variableUpdatePolicy: (self variableUpdatePolicyClass newOn: self)
]

{ #category : #testing }
LcsAccessorSlot >> isGlobalCollectionRefenceSlot [
	^ false
]

{ #category : #testing }
LcsAccessorSlot >> isGlobalCollectionRefenceSlotTo: aSlotName [
	^ false
]

{ #category : #testing }
LcsAccessorSlot >> isGlobalCollectionSlot [
	^ false
]

{ #category : #testing }
LcsAccessorSlot >> isInstanceVariableDefined [
	^ self domainClass allInstVarNames includes: self slotName
]

{ #category : #testing }
LcsAccessorSlot >> isLocalCollectionSlot [
	^ false
]

{ #category : #testing }
LcsAccessorSlot >> isNilAllowed [
	^ self allowNil == true
]

{ #category : #testing }
LcsAccessorSlot >> isNotRequired [
	^ self isRequired not
]

{ #category : #testing }
LcsAccessorSlot >> isNullAllowed [
	^ self allowNull == true
]

{ #category : #testing }
LcsAccessorSlot >> isNullObject: anObject [
	<TODO: 'This needs to be flushed out'> 
	^ false
]

{ #category : #testing }
LcsAccessorSlot >> isOptional [
	^ self required ~~ true
]

{ #category : #testing }
LcsAccessorSlot >> isRequired [
	^ self required == true
]

{ #category : #configuration }
LcsAccessorSlot >> makeDirectUpdateOfVariable [
	self variableUpdatePolicyClassName: LcsDirectVariableUpdatePolicy name.
	self initializeVariableUpdatePolicy
]

{ #category : #configuration }
LcsAccessorSlot >> makeUpdateOfVariableViaUnitOfWork [
	self variableUpdatePolicyClassName: LcsUnitOfWorkVariableUpdatePolicy name.
	self initializeVariableUpdatePolicy
]

{ #category : #defaults }
LcsAccessorSlot >> newObjectWithParent: parentDomainObject [
		| newObject |
		newObject := self slotTypes any basicNew.
		parentDomainObject perform: self setterSelector with: newObject.
		^ newObject
			parent: parentDomainObject;
			initialize;
			yourself
]

{ #category : #'slot model' }
LcsAccessorSlot >> persistedSlotVarIn: aDomainObject [
	"self traceCr: 'persistedSlotVarIn: ' , aDomainObject printString."
	"aDomainObject isInAddingState ifTrue: [ ^ nil ]."
	^ aDomainObject instVarNamed: self slotName asString
]

{ #category : #accessing }
LcsAccessorSlot >> postUpdateActions [
	^ postUpdateActions
]

{ #category : #accessing }
LcsAccessorSlot >> postUpdateActions: anObject [
	postUpdateActions := anObject
]

{ #category : #properties }
LcsAccessorSlot >> prevalidationTransformBlock [
	^ self propertyAt: 'prevalidationTransformBlock'
]

{ #category : #properties }
LcsAccessorSlot >> prevalidationTransformBlock: aBlock [
	self propertyAt: 'prevalidationTransformBlock' put: aBlock
]

{ #category : #magritte }
LcsAccessorSlot >> prevalidationTransformBlockDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Prevalidation Transform Block [ :value :slot | ';
		priority: 11;
		default: '';
		accessor: (LcsMABlockPluggableAccessor 
						accessors: #(#prevalidationTransformBlock )
						arguments: LcsAccessorSlot valueSlotBlockArguments);
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : #validations }
LcsAccessorSlot >> removePostUpdateAction: anUpdateAction [
	self postUpdateActions remove: anUpdateAction
]

{ #category : #validations }
LcsAccessorSlot >> removeValidationCondition: aValidationCondition [
	self validationConditions removeValidationCondition: aValidationCondition
]

{ #category : #validations }
LcsAccessorSlot >> removeValidationConditionWithDescription: aString [
	self validationConditions removeValidationConditionWithDescription: aString
]

{ #category : #properties }
LcsAccessorSlot >> required [
	^ self propertyAt: 'required'
]

{ #category : #properties }
LcsAccessorSlot >> required: anObject [
	self propertyAt: 'required' put: anObject
]

{ #category : #magritte }
LcsAccessorSlot >> requiredDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Required';
		priority: 10;
		accessor: #'required';
		comment: 'Indicates that this slot must have a non-nil/empty value';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
"		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique slot name of at least two characters in length';
		addCondition: [ :aValue | (existingInstvarNames includes: aValue asString trim asSymbol) not ] labelled: 'Slot already exists';"
		"addCondition: [ :aValue | aValue trim isEmpty  ] labelled: 'Enter a unique slot name of at least two characters in length';"
		"addCondition: [ :aValue | aValue trim isEmpty  ] labelled: 'Enter a unique slot name of at least two characters in length';"
		beRequired

]

{ #category : #private }
LcsAccessorSlot >> setUpPendingAddOf: aDomainObject in: aUnitOfWork [
	"collection slots need to implement logic here"
]

{ #category : #private }
LcsAccessorSlot >> setUpPendingDeleteOf: aDomainObject in: aUnitOfWork [
	"collection slots need to implement logic here"
]

{ #category : #'slot model' }
LcsAccessorSlot >> setterSelector [
	^ (self getterSelector , ':') asSymbol
		
]

{ #category : #'slot model' }
LcsAccessorSlot >> signalInvalidSlotTypeError: anObject for: aDomainObject [ 
	LcsInvalidSlotTypeError
		signalInvalidType: anObject
		forSlot: self
		for: aDomainObject
]

{ #category : #validation }
LcsAccessorSlot >> slotDoesNotExistMessage [
	^ 'Slot name ' , self slotName asString , ' does not exist in '
		, self domainClass name
]

{ #category : #'slot model' }
LcsAccessorSlot >> slotVarDirectlyPut: anObject in: aDomainObject [
	aDomainObject instVarNamed: self slotName asString put: anObject

]

{ #category : #'slot model' }
LcsAccessorSlot >> slotVarPut: anObject in: aDomainObject [
	| transformedObject |
	transformedObject := self prevalidationTransformBlock cull: anObject cull: self cull: nil.

	self variableUpdatePolicy slotVarPut: transformedObject in: aDomainObject
]

{ #category : #validations }
LcsAccessorSlot >> validate: aValue [
	^ (LcsConditionsValidator newOn: self)
		validate: aValue;
		yourself
]

{ #category : #validations }
LcsAccessorSlot >> validate: aValue context: aDomainObject [
	(LcsConditionsValidator newOn: self)
		validate: aValue context: aDomainObject
]

{ #category : #'slot model' }
LcsAccessorSlot >> validate: anObject for: aDomainObject [
	| oldValue |
	oldValue := aDomainObject perform: self getterSelector.
	self verifySlotType: anObject for: aDomainObject.
	(self isNilAllowed and: [ anObject isNil and: [ oldValue isNil ] ]) ifTrue: [ ^self ].
	(self isNullAllowed and: [ (self isNullObject: anObject)]) ifTrue: [ ^ self ].
	self validationConditions 
		validate: anObject 
		context: aDomainObject 
		oldValue: oldValue
]

{ #category : #validations }
LcsAccessorSlot >> validate: anObject visitor: aValidationVisitor [
	<TODO: 'this needs work or should be removed'>
	self validationConditions do: [ :eachCondition | ]
]

{ #category : #validations }
LcsAccessorSlot >> validate: aValue withValidator: aValidator [
	self validationConditions validate: aValue withValidator: aValidator
]

{ #category : #properties }
LcsAccessorSlot >> validationConditions [
	^ self propertyAt: 'validationConditions'
]

{ #category : #properties }
LcsAccessorSlot >> validationConditions: anObject [
	self propertyAt: 'validationConditions' put: anObject
]

{ #category : #magritte }
LcsAccessorSlot >> validationConditionsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		  accessor: (MAChainAccessor accessors: #(#validationConditions #collection));
		  label: 'Validation Conditions';
		  default: #(  );
		  classes: { LcsValidationCondition };
		  priority: 35;
		  beModifiable;
		  blocItemStencil: [ :anItemViewModel :anItemIndex | 
			  anItemViewModel asElement
				  fitContent;
				  border:
					  (BlBorder
						   paint: BrGlamorousColors disabledButtonBorderColor
						   width: 1);
				  margin: (BlInsets
						   top: 0
						   right: 5
						   bottom: 5
						   left: 0);
				  padding: (BlInsets all: 5);
				  background: Color white ];
		  newItemStencil: [ LcsValidationCondition new
		  						parent: self validationConditions;
		  						yourself ]
]

{ #category : #validating }
LcsAccessorSlot >> validator [
	^ LcsConditionsValidator new
]

{ #category : #configuration }
LcsAccessorSlot >> valueDomainObjectOldValueBlockArguments [
	^ self class valueDomainObjectOldValueBlockArguments
]

{ #category : #configuration }
LcsAccessorSlot >> valueSlotBlockArguments [
	^ self class valueSlotBlockArguments
]

{ #category : #accessing }
LcsAccessorSlot >> variableUpdatePolicy [
	^ variableUpdatePolicy
]

{ #category : #accessing }
LcsAccessorSlot >> variableUpdatePolicy: anObject [
	variableUpdatePolicy := anObject
]

{ #category : #properties }
LcsAccessorSlot >> variableUpdatePolicyClass [
	^ self variableUpdatePolicyClassName asClass
]

{ #category : #properties }
LcsAccessorSlot >> variableUpdatePolicyClassName [
	^ self properties at: 'variableUpdatePolicyClassName'
]

{ #category : #properties }
LcsAccessorSlot >> variableUpdatePolicyClassName: aClassName [
	self properties at: 'variableUpdatePolicyClassName' put: aClassName
]

{ #category : #'slot model' }
LcsAccessorSlot >> verifySlotType: anObject for: aDomainObject [
	[ self verifyType: anObject for: aDomainObject ]
		on: LcsInvalidSlotTypeError
		do: [ :signal |
			self currentUnitOfWork removeAddOf: anObject.
			signal signal ]
]

{ #category : #'slot model' }
LcsAccessorSlot >> verifySlotTypeOf: anObject for: aDomainObject [
	self slotTypes
		detect: [ :eachClass | anObject isKindOf: eachClass ]
		ifNone: [ self signalInvalidSlotTypeError: anObject for: aDomainObject  ]
]

{ #category : #'slot model' }
LcsAccessorSlot >> verifyType: anObject for: aDomainObject [
	(self isNilAllowed and: [ anObject isNil ]) ifTrue: [ ^ true ].
	self verifySlotTypeOf: anObject for: aDomainObject
]

{ #category : #'slot model' }
LcsAccessorSlot >> verifyTypeBlock: anObject [
	^ [ :eachClass | anObject isKindOf: eachClass ]
]
