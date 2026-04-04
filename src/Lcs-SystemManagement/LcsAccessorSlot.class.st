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
	#name : 'LcsAccessorSlot',
	#superclass : 'LcsBaseSlot',
	#instVars : [
		'validator',
		'variableUpdatePolicy'
	],
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'configuration' }
LcsAccessorSlot class >> domainObjectSlotBlockArguments [
	^ #('parentDomainObject' 'slot')
]

{ #category : 'testing' }
LcsAccessorSlot class >> isAbstract [
	^ self name = #LcsAccessorSlot
]

{ #category : 'testing' }
LcsAccessorSlot class >> isAccessorSlot [
	^ true
]

{ #category : 'configuration' }
LcsAccessorSlot class >> valueDomainObjectOldValueBlockArguments [
	^ #('value' 'parentDomainObject' 'oldValue')
]

{ #category : 'configuration' }
LcsAccessorSlot class >> valueSlotBlockArguments [
	^ #('value' 'slot')
]

{ #category : 'slot model' }
LcsAccessorSlot >> _currentSlotVarIn: aDomainObject [
	^ (self changedSlotRecordFor: aDomainObject)
		ifNil: [ self persistedSlotVarIn: aDomainObject ]
		ifNotNil: [ :changedSlotRecord | changedSlotRecord newValue ]
]

{ #category : 'object initialization' }
LcsAccessorSlot >> _initialValueFor: aDomainObject [ 
	^ self initialValueBlock cull: aDomainObject cull: self
]

{ #category : 'object initialization' }
LcsAccessorSlot >> _initializeSlotWithValue: aValue in: aDomainObject [
	self slotVarPut: aValue in: aDomainObject oldValue: LcsApplicationEnvironment undefinedObject
]

{ #category : 'post update actions' }
LcsAccessorSlot >> addPostUpdateAction: anUpdateAction [
	self postUpdateActions addAction: anUpdateAction
]

{ #category : 'slot model' }
LcsAccessorSlot >> addSlotTypeRule: aRule [
	^ self slotTypeRules addRule: aRule
]

{ #category : 'private' }
LcsAccessorSlot >> addSubclassesOf: aClass [
	aClass subclassesDo: [ :each | self addSlotType: each ] 
]

{ #category : 'validations' }
LcsAccessorSlot >> addValidateConfigurationResultTo: aValidator [
	(self domainClass allInstVarNames includes: self slotName)
		ifFalse: [ aValidator
				add: (LcsValidatorIssueMessage newOn: self message: self slotDoesNotExistMessage) ]
]

{ #category : 'slot model' }
LcsAccessorSlot >> addValidationRule: aRule [
	^ self validationRules addRule: aRule
]

{ #category : 'slot model' }
LcsAccessorSlot >> addValidationRuleBlock: aBlock description: aString [
	^ self validationRules addRuleBlock: aBlock description: aString
]

{ #category : 'properties' }
LcsAccessorSlot >> allowNil [ 
	^ self propertyAt: 'allowNil'
]

{ #category : 'properties' }
LcsAccessorSlot >> allowNil: newPropertyValue [
	| currentPropertyValue |
	currentPropertyValue := self propertyAt: 'allowNil' ifAbsent: [ nil ].
	newPropertyValue == true 
		ifTrue: [
			currentPropertyValue ~~ true ifTrue: [
				self slotTypeRules addFirstRule: LcsAllowNilSlotTypeRule new ].
			self propertyAt: 'allowNil' put: newPropertyValue.
			^ self ].
	newPropertyValue == false
		ifTrue: [ 
			currentPropertyValue == true ifTrue: [
				self slotTypeRules removeRuleWithDescription: LcsAllowNilSlotTypeRule new defaultDescription ].
		self propertyAt: 'allowNil' put: newPropertyValue.
		^ self ].
	LcsError signal: 'Attempt to update with a non-Boolean value'
]

{ #category : 'magritte' }
LcsAccessorSlot >> allowNilDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Allow Nil';
		priority: 10;
		accessor: #'allowNil';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]

]

{ #category : 'properties' }
LcsAccessorSlot >> allowNull [
	^ self propertyAt: 'allowNull' ifAbsent: [ false ]
]

{ #category : 'properties' }
LcsAccessorSlot >> allowNull: newPropertyValue [
	| currentPropertyValue |
	currentPropertyValue := self propertyAt: 'allowNull' ifAbsent: [ nil ].
	newPropertyValue == true 
		ifTrue: [
			currentPropertyValue ~~ true ifTrue: [
				self slotTypeRules addNullRule: LcsAllowNullSlotTypeRule new ].
			self propertyAt: 'allowNull' put: newPropertyValue.
			^ self ].
	newPropertyValue == false
		ifTrue: [ 
			currentPropertyValue == true ifTrue: [
				self slotTypeRules removeRuleWithDescription: LcsAllowNullSlotTypeRule new defaultDescription ].
		self propertyAt: 'allowNull' put: newPropertyValue.
		^ self ].
	LcsError signal: 'Attempt to update with a non-Boolean value'
]

{ #category : 'magritte' }
LcsAccessorSlot >> allowNullDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Allow Null';
		priority: 10;
		accessor: #'allowNull';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]

]

{ #category : 'slot model' }
LcsAccessorSlot >> assignParent: aDomainObject to: newValue [
	newValue isDomainObject ifTrue: [
		newValue parent: aDomainObject ]
]

{ #category : 'audit' }
LcsAccessorSlot >> audit: anObject withAuditor: anAuditor [
	| value |
	value := self _currentSlotVarIn: anObject.
	[ self validateSlotType: value context: anObject oldValue: value ]
		on: LcsInvalidSlotTypeError
		do: [ :signal |
			anAuditor addErrorDescription: signal auditErrorMessage.
			signal return: nil ].
	[ self validateRules: value context: anObject oldValue: value ]
		on: LcsError
		do: [ :signal |
			anAuditor addErrorDescription: signal auditErrorMessage.
			signal return: nil ]
]

{ #category : 'configuration' }
LcsAccessorSlot >> beAllowInitialNil [
	self beAllowNil.
	(self validationRules hasRuleWithDescription: LcsAllowInitialNilRule new description)
		ifFalse: [self validationRules addFirstRule: (LcsAllowInitialNilRule new) ]
]

{ #category : 'configuration' }
LcsAccessorSlot >> beAllowInitialNull [
	self beAllowNull.
	(self validationRules hasRuleWithDescription: LcsAllowInitialNullRule new description)
		ifFalse: [self validationRules addFirstRule: (LcsAllowInitialNullRule new) ]
]

{ #category : 'configuration' }
LcsAccessorSlot >> beAllowNil [ 
	self allowNil: true
]

{ #category : 'configuration' }
LcsAccessorSlot >> beAllowNull [ 
	self allowNull: true
]

{ #category : 'configuration' }
LcsAccessorSlot >> beDisallowInitialNil [
	self beDisallowNil.
	self validationRules removeRuleWithDescription: LcsAllowInitialNilRule new description
]

{ #category : 'configuration' }
LcsAccessorSlot >> beDisallowInitialNull [
	self allowNull.
	(self validationRules hasRuleWithDescription: LcsAllowInitialNullRule new description)
		ifFalse: [self validationRules addFirstRule: (LcsAllowInitialNullRule new) ]
]

{ #category : 'configuration' }
LcsAccessorSlot >> beDisallowNil [ 
	self allowNil: false
]

{ #category : 'configuration' }
LcsAccessorSlot >> beDisallowNull [
	self allowNull: false
]

{ #category : 'configuration' }
LcsAccessorSlot >> beOptional [
	self required: false
]

{ #category : 'configuration' }
LcsAccessorSlot >> beRequired [
	self required: true
]

{ #category : 'history saving' }
LcsAccessorSlot >> changeHistoryRepresentationIn: aNewObject [
	^ aNewObject isDomainObject ifTrue: [ aNewObject uuid ] ifFalse: [ aNewObject ]
]

{ #category : 'testing' }
LcsAccessorSlot >> changedSlotRecordFor: aDomainObject [
	^ self currentUnitOfWork
		changedSlotRecordFor: aDomainObject
		slotNamed: self slotName
]

{ #category : 'slot model' }
LcsAccessorSlot >> currentSlotVarIn: aDomainObject [
	self hasPermissionToReadSlotOf: aDomainObject.
	^ self _currentSlotVarIn: aDomainObject
]

{ #category : 'defaults' }
LcsAccessorSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | self newInstanceOfFirstSlotTypeIn: slot parent: parentDomainObject ]
]

{ #category : 'defaults' }
LcsAccessorSlot >> defaultInitialValueBlockSourceCode [
	^ self defaultInitialValueBlock compiledBlock sourceNode sourceCode
]

{ #category : 'defaults' }
LcsAccessorSlot >> defaultPragmaSelector [
	^ self class accessorSlotDefinitionName
]

{ #category : 'defaults' }
LcsAccessorSlot >> defaultPrevalidationTransformBlock [
	^ [ :value :slot | value ]
]

{ #category : 'defaults' }
LcsAccessorSlot >> defaultTypeOfSlotRuleClass [
	^ LcsInstanceIsKindOfSlotTypesRule
]

{ #category : 'configuration' }
LcsAccessorSlot >> domainObjectSlotBlockArguments [
	^ self class domainObjectSlotBlockArguments
]

{ #category : 'gt views' }
LcsAccessorSlot >> gtDomainMetaFor: aView [
	<gtView>
	self parent isNil ifTrue: [ ^ aView empty ].
	^ aView explicit
		title: 'Domain Meta';
		priority: 200;
		stencil: [ (GtCoderElement forObject: self domainClass) disablePlayPage beNormalLevel ]
]

{ #category : 'gt views' }
LcsAccessorSlot >> gtLiveFor: aView [
	^ (super gtLiveFor: aView)
		actionUpdateButton
]

{ #category : 'gt views' }
LcsAccessorSlot >> gtMagritteFor: aView [
	^ (super gtMagritteFor: aView)
		actionUpdateButton
]

{ #category : 'gt views' }
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

{ #category : 'gt views' }
LcsAccessorSlot >> gtViewSlotModelChildren [
	^ {
		LcsSlotModelViewItem newLabel: 'domainClass' item: self domainClass.
		LcsSlotModelViewItem newLabel: 'slotName' item: self slotName.
		LcsSlotModelViewItem newLabel: 'slotTypes' item: self slotTypeClassNames.
		LcsSlotModelViewItem newLabel: 'required' item: self isRequired.
		}
]

{ #category : 'slot model' }
LcsAccessorSlot >> hasPermissionToReadSlotOf: aDomainObject [
	self securityModule
		"ifNotNil: [ :securityModule | securityModule hasPermissionToReadSlot: self in: aDomainObject ]"
]

{ #category : 'slot model' }
LcsAccessorSlot >> hasPermissionToWriteSlotOf: aDomainObject [
	self securityModule
		ifNotNil: [ :securityModule | securityModule hasPermissionToWriteSlot: self in: aDomainObject ]
]

{ #category : 'properties' }
LcsAccessorSlot >> initialValue [
	^ self initialValueBlock cull: nil cull: self
]

{ #category : 'properties' }
LcsAccessorSlot >> initialValue: anObject [
	self
		initialValueBlock: (self class compiler
				evaluate: '[ :parentDomainObject :slot | ' , anObject asString , ' ]')
]

{ #category : 'properties' }
LcsAccessorSlot >> initialValueBlock [
	^ self propertyAt: 'initialValueBlock'
]

{ #category : 'properties' }
LcsAccessorSlot >> initialValueBlock: aBlock [ 
	self propertyAt: 'initialValueBlock' put: aBlock
]

{ #category : 'magritte' }
LcsAccessorSlot >> initialValueBlockDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: ('Initial Value Block [ :<1s> : <2s> | ' expandMacrosWithArguments: LcsAccessorSlot domainObjectSlotBlockArguments);
		priority: 10;
		default: '';
		accessor: (LcsMABlockPluggableAccessor 
						accessors: #(#initialValueBlock )
						arguments: LcsAccessorSlot domainObjectSlotBlockArguments);
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : 'object initialization' }
LcsAccessorSlot >> initialValueFor: aDomainObject [
	| newValue |
	LcsLogger logGettingInitialValue.
	newValue := self _initialValueFor: aDomainObject.
	LcsLogger logReturningInitialValue: newValue.
	^ newValue
]

{ #category : 'initialize' }
LcsAccessorSlot >> initialize [
	super initialize.
	self makeUpdateOfVariableViaUnitOfWork.
	self slotTypeRules: (LcsSlotTypeRules newOn: self).
	self slotTypeRules addRule: self defaultTypeOfSlotRuleClass new.
	self validationRules: (LcsValidationRules newOn: self).
	self postUpdateActions: (LcsUpdateActions newOn: self).
	self initialValueBlock: self defaultInitialValueBlock.
	self prevalidationTransformBlock: self defaultPrevalidationTransformBlock.
	self allowNil: false.
	self allowNull: false.
	self required: false.
]

{ #category : 'object initialization' }
LcsAccessorSlot >> initializeSlotValueIn: aDomainObject [
	| initialValue |
	LcsLogger logReceiver: thisContext receiver message: thisContext message.
	LcsLogger indent.
	initialValue := self initialValueFor: aDomainObject.
	self _initializeSlotWithValue: initialValue in: aDomainObject.
	LcsLogger outdent.
]

{ #category : 'object initialization' }
LcsAccessorSlot >> initializeSlotWithValue: aValue in: aDomainObject [
	self slotVarPut: aValue in: aDomainObject oldValue: LcsApplicationEnvironment undefinedObject
]

{ #category : 'object initialization' }
LcsAccessorSlot >> initializeUnintializedSlotValueIn: aDomainObject [
	(self _currentSlotVarIn: aDomainObject) ifNotNil: [ ^ self ].
	self initializeSlotValueIn: aDomainObject
]

{ #category : 'configuration' }
LcsAccessorSlot >> initializeVariableUpdatePolicy [
	self variableUpdatePolicy: (self variableUpdatePolicyClass newOn: self)
]

{ #category : 'testing' }
LcsAccessorSlot >> isGlobalCollectionRefenceSlot [
	^ false
]

{ #category : 'testing' }
LcsAccessorSlot >> isGlobalCollectionRefenceSlotTo: aSlotName [
	^ false
]

{ #category : 'testing' }
LcsAccessorSlot >> isGlobalCollectionSlot [
	^ false
]

{ #category : 'testing' }
LcsAccessorSlot >> isInstanceVariableDefined [
	^ self domainClass allInstVarNames includes: self slotName
]

{ #category : 'testing' }
LcsAccessorSlot >> isLocalCollectionSlot [
	^ false
]

{ #category : 'testing' }
LcsAccessorSlot >> isNilAllowed [
	^ self allowNil == true
]

{ #category : 'testing' }
LcsAccessorSlot >> isNotRequired [
	^ self isRequired not
]

{ #category : 'testing' }
LcsAccessorSlot >> isNullAllowed [
	^ self allowNull == true
]

{ #category : 'testing' }
LcsAccessorSlot >> isNullObject: anObject [
	<TODO: 'This needs to be flushed out'> 
	^ false
]

{ #category : 'testing' }
LcsAccessorSlot >> isOptional [
	^ self required ~~ true
]

{ #category : 'testing' }
LcsAccessorSlot >> isRequired [
	^ self required == true
]

{ #category : 'configuration' }
LcsAccessorSlot >> makeDirectUpdateOfVariable [
	self variableUpdatePolicyClassName: LcsDirectVariableUpdatePolicy name.
	self initializeVariableUpdatePolicy
]

{ #category : 'configuration' }
LcsAccessorSlot >> makeUpdateOfVariableViaUnitOfWork [
	self variableUpdatePolicyClassName: LcsUnitOfWorkVariableUpdatePolicy name.
	self initializeVariableUpdatePolicy
]

{ #category : 'defaults' }
LcsAccessorSlot >> newInstanceOfFirstSlotTypeIn: slot parent: parentDomainObject [
	^ slot slotTypes any new
		parent: parentDomainObject;
		yourself
]

{ #category : 'defaults' }
LcsAccessorSlot >> newObjectWithParent: parentDomainObject [
		| newObject |
		newObject := self slotTypes any basicNew.
		parentDomainObject perform: self setterSelector with: newObject.
		^ newObject
				parent: parentDomainObject;
				initialize;
				yourself
]

{ #category : 'slot model' }
LcsAccessorSlot >> persistedSlotVarIn: aDomainObject [
	"self traceCr: 'persistedSlotVarIn: ' , aDomainObject printString."
	"aDomainObject isInAddingState ifTrue: [ ^ nil ]."
	^ aDomainObject instVarNamed: self slotName asString
]

{ #category : 'accessing' }
LcsAccessorSlot >> postUpdateActions [
	^ self properties at: 'postUpdateActions'
]

{ #category : 'accessing' }
LcsAccessorSlot >> postUpdateActions: anObject [
	self properties at: 'postUpdateActions' put:anObject
]

{ #category : 'magritte' }
LcsAccessorSlot >> postUpdateActionsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		  accessor: (MAChainAccessor accessors: #(#postUpdateActions #collection));
		  label: 'Post Update Actions';
		  default: #(  );
		  classes: { LcsUpdateAction };
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
		  newItemStencil: [ LcsUpdateAction new ]
]

{ #category : 'properties' }
LcsAccessorSlot >> prevalidationTransformBlock [
	^ self propertyAt: 'prevalidationTransformBlock'
]

{ #category : 'properties' }
LcsAccessorSlot >> prevalidationTransformBlock: aBlock [
	self propertyAt: 'prevalidationTransformBlock' put: aBlock
]

{ #category : 'magritte' }
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

{ #category : 'slot model' }
LcsAccessorSlot >> removeAction: anUpdateAction [
	self postUpdateActions remove: anUpdateAction
]

{ #category : 'slot model' }
LcsAccessorSlot >> removeValidationRule: aRule [
	self validationRules removeRule: aRule
]

{ #category : 'slot model' }
LcsAccessorSlot >> removeValidationRuleWithDescription: aString [
	self validationRules removeRuleWithDescription: aString
]

{ #category : 'properties' }
LcsAccessorSlot >> required [
	^ self propertyAt: 'required'
]

{ #category : 'properties' }
LcsAccessorSlot >> required: anObject [
	self propertyAt: 'required' put: anObject
]

{ #category : 'magritte' }
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

{ #category : 'private' }
LcsAccessorSlot >> setUpPendingAddOf: aDomainObject in: aUnitOfWork [
	"collection slots need to implement logic here"
]

{ #category : 'private' }
LcsAccessorSlot >> setUpPendingDeleteOf: aDomainObject in: aUnitOfWork [
	"collection slots need to implement logic here"
]

{ #category : 'slot model' }
LcsAccessorSlot >> setterSelector [
	^ (self getterSelector , ':') asSymbol
		
]

{ #category : 'error signalling' }
LcsAccessorSlot >> signalInvalidSlotTypeError: anObject for: aDomainObject [ 
	^ LcsInvalidSlotTypeError
		signalInvalidType: anObject
		forSlot: self
		for: aDomainObject
]

{ #category : 'error signalling' }
LcsAccessorSlot >> slotDoesNotExistMessage [
	^ 'Slot name ' , self slotName asString , ' does not exist in ' , self domainClass name
]

{ #category : 'properties' }
LcsAccessorSlot >> slotTypeRules [
	^ self propertyAt: 'slotTypeRules'
]

{ #category : 'properties' }
LcsAccessorSlot >> slotTypeRules: anObject [
	self propertyAt: 'slotTypeRules' put: anObject
]

{ #category : 'properties' }
LcsAccessorSlot >> slotTypeValidations [
	^ self propertyAt: 'slotTypeValidations'
]

{ #category : 'slot model' }
LcsAccessorSlot >> slotVarDirectlyPut: anObject in: aDomainObject [
	aDomainObject instVarNamed: self slotName asString put: anObject
]

{ #category : 'slot model' }
LcsAccessorSlot >> slotVarPut: anObject in: aDomainObject [
	| existingValue |
	existingValue := aDomainObject perform: self getterSelector.
	self slotVarPut: anObject in: aDomainObject oldValue: existingValue
]

{ #category : 'slot model' }
LcsAccessorSlot >> slotVarPut: anObject in: aDomainObject oldValue: anOldValue [
	| transformedObject |
	transformedObject := self prevalidationTransformBlock
			cull: anObject
			cull: self
			cull: aDomainObject.
	self hasPermissionToWriteSlotOf: aDomainObject.
	self
		updateVariableIn: aDomainObject
		oldValue: anOldValue
		with: transformedObject.
	self postUpdateActions
		execute: transformedObject
		context: aDomainObject
		oldValue: anOldValue
]

{ #category : 'slot model' }
LcsAccessorSlot >> updateVariableIn: aDomainObject oldValue: anOldValue with: transformedObject [
	self variableUpdatePolicy
		slotVarPut: transformedObject
		in: aDomainObject
		oldValue: anOldValue
]

{ #category : 'validations' }
LcsAccessorSlot >> validate: aValue [
	^ self validate: aValue context: nil
]

{ #category : 'validations' }
LcsAccessorSlot >> validate: aValue context: aDomainObject [
	^ self validate: aValue context: aDomainObject oldValue: nil
]

{ #category : 'validations' }
LcsAccessorSlot >> validate: anObject context: aDomainObject oldValue: anOldvalue [
	self
		validateSlotType: anObject
		context: aDomainObject
		oldValue: anOldvalue.
	^ self
		validateRules: anObject
		context: aDomainObject
		oldValue: anOldvalue
]

{ #category : 'validations' }
LcsAccessorSlot >> validate: anObject visitor: aValidationVisitor [
	<TODO: 'this needs work or should be removed'>
	self validationRules do: [ :eachCondition | ]
]

{ #category : 'validations' }
LcsAccessorSlot >> validate: aValue withValidator: aValidator [
	self validationRules validate: aValue withValidator: aValidator
]

{ #category : 'validations' }
LcsAccessorSlot >> validateRules: anObject context: aDomainObject oldValue: anOldvalue [
	^ self validationRules
		validate: anObject
		context: aDomainObject
		oldValue: anOldvalue
]

{ #category : 'validations' }
LcsAccessorSlot >> validateSlotType: anObject [
	^ self validateSlotType: anObject context: nil
]

{ #category : 'validations' }
LcsAccessorSlot >> validateSlotType: anObject context: aDomainObject [
	^ self validateSlotType: anObject context: aDomainObject oldValue: nil
]

{ #category : 'validations' }
LcsAccessorSlot >> validateSlotType: anObject context: aDomainObject oldValue: anOldvalue [
	^ self slotTypeRules
		validate: anObject
		context: aDomainObject
		oldValue: anOldvalue
]

{ #category : 'properties' }
LcsAccessorSlot >> validationRules [
	^ self propertyAt: 'validationRules'
]

{ #category : 'properties' }
LcsAccessorSlot >> validationRules: anObject [
	self propertyAt: 'validationRules' put: anObject
]

{ #category : 'magritte' }
LcsAccessorSlot >> validationRulesDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		  accessor: (MAChainAccessor accessors: #(#validationRules #collection));
		  label: 'Validation Rules';
		  default: #(  );
		  classes: { LcsValidationRule };
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
		  newItemStencil: [ LcsValidationRule new
		  						parent: self validationRules;
		  						yourself ]
]

{ #category : 'configuration' }
LcsAccessorSlot >> valueDomainObjectOldValueBlockArguments [
	^ self class valueDomainObjectOldValueBlockArguments
]

{ #category : 'configuration' }
LcsAccessorSlot >> valueSlotBlockArguments [
	^ self class valueSlotBlockArguments
]

{ #category : 'accessing' }
LcsAccessorSlot >> variableUpdatePolicy [
	^ variableUpdatePolicy
]

{ #category : 'accessing' }
LcsAccessorSlot >> variableUpdatePolicy: anObject [
	variableUpdatePolicy := anObject
]

{ #category : 'properties' }
LcsAccessorSlot >> variableUpdatePolicyClass [
	^ self variableUpdatePolicyClassName asClass
]

{ #category : 'properties' }
LcsAccessorSlot >> variableUpdatePolicyClassName [
	^ self properties at: 'variableUpdatePolicyClassName'
]

{ #category : 'properties' }
LcsAccessorSlot >> variableUpdatePolicyClassName: aClassName [
	self properties at: 'variableUpdatePolicyClassName' put: aClassName
]
