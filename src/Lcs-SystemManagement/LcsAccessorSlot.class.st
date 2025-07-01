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
		'variableUpdatePolicy'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LcsAccessorSlot >> _slotVarPut: anObject in: aDomainObject [
	self verifyType: anObject for: aDomainObject.
	self currentUnitOfWork
		setValueIn: aDomainObject
		slot: self
		to: anObject
]

{ #category : #validation }
LcsAccessorSlot >> addValidateConfigurationResultTo: aValidator [
	(self domainClass allInstVarNames includes: self slotName)
		ifFalse: [ aValidator
				add: (LcsValidatorIssueMessage newOn: self message: self slotDoesNotExistMessage) ]
]

{ #category : #properties }
LcsAccessorSlot >> allowNil [ 
	^ self properties at: 'allowNil' ifAbsent: [ ]
]

{ #category : #properties }
LcsAccessorSlot >> allowNil: anObject [
	self properties at: 'allowNil' put: anObject
]

{ #category : #'slot model' }
LcsAccessorSlot >> assignParent: aDomainObject to: newValue [
	newValue isDomainObject ifTrue: [
		newValue parent: aDomainObject ]
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

{ #category : #'as yet unclassified' }
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
	^ [ :parentDomainObject | 
		(self slotTypes any new)
			parent: parentDomainObject;
			yourself ]
]

{ #category : #printing }
LcsAccessorSlot >> defaultInitialValueBlockSourceCode [
	^ self defaultInitialValueBlock compiledBlock sourceNode sourceCode
]

{ #category : #'slot model' }
LcsAccessorSlot >> getterSelector [
	| substring1 substring2 |
	substring1 := (self slotName at: 1) asLowercase asString.
	substring2 := self slotName asCamelCase copyFrom: 2 to: self slotName size.
	^ (substring1 , substring2) asSymbol
		
]

{ #category : #'gt views' }
LcsAccessorSlot >> gtCreateClassAndValueElementFor: aColumn [
	^ aColumn
		cellStencil: [ BrHorizontalPane new
				hMatchParent;
				vFitContent;
				alignCenter ];
		dataBinder: [ :itemElement :aNode | 
			| nodeIcon |
			self traceCr: 'Item: ' , itemElement printString , '- Node: ' , aNode printString.
			nodeIcon := [ aNode value gtInspectorIcon
					ifNil: [ aNode value class iconNamed: aNode value class systemIconName ] ]
					on: Error
					do: [ :error | Smalltalk ui icons iconNamed: #smallWarningIcon ].
					
			itemElement
				removeChildren;
				addChild: nodeIcon asElement;
				addChild: (BrLabel new
							aptitude: BrGlamorousListLabelAptitude;
							text: aNode value displayString;
							alignCenterLeft;
							hMatchParent;
							vFitContent) ]
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
LcsAccessorSlot >> gtSlotAttributesViewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Attributes';
		priority: 15;
		items: [ self gtSlotDefinitionAttributes ];
		column: 'Option' 
			text: #key 
			width: 200;
		column: 'Value' do: [ :aColumn | self gtCreateClassAndValueElementFor: aColumn ];
		send: #value;
		actionUpdateButton;		
		yourself
]

{ #category : #'gt views' }
LcsAccessorSlot >> gtSlotDefinitionAttributes [
	| collection |
	collection := 
		OrderedCollection new
			add: 'slotDefinition' -> self;
			add: 'slotDefinitionClass' -> self class;
			add: 'domainClass' -> self newDomainClassName;
			add: 'slotName' -> self slotName;
			add: 'slotTypes' -> self slotTypesList;
			add: 'required' -> self isRequired;
			add: 'allowNil' -> self isNilAllowed;
			add: 'initialValueBlock' -> self initialValueBlockSourceCode;
			yourself.
	self validationConditions do: [ :each |
		collection add: each conditionBlock asString -> each description ].
	^ collection
]

{ #category : #'gt views' }
LcsAccessorSlot >> gtSlotDefinitionMethodViewFor: aView [
	<gtView>

	self domainClass ifNil: [ ^ aView empty ].
	
	^ aView explicit
		title: 'Methods';
		priority: 20;
		stencil: [ 
			| methods |
			methods := self domainClass slotDefinitionMethodsNamed: self slotDefinitionSelector.
			self domainClass addInstanceMethodNamed: self getterSelector asSymbol to: methods.
			self domainClass addInstanceMethodNamed: self setterSelector asSymbol to: methods.
			GtPharoMethodsCoder forItems: methods]
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
LcsAccessorSlot >> gtSlotTypesViewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Slot Types';
		priority: 10;
		items: [ self slotTypes];
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Item' do: [ :aColumn | 
			aColumn
				cellStencil: [ :eachItem | GtPhlowLabelWithIcon new ];
				dataBinder: [ :aCellElement :eachItem | | icon class label |
					class := eachItem isClass 
								ifTrue: [ eachItem ] 
								ifFalse: [ eachItem class ].
					icon := aCellElement gtSafeIconNamed: class gtSystemIconName.
					label := eachItem isClass 
								ifTrue: [eachItem name asString ] 
								ifFalse: [ eachItem gtDisplayText ].
					aCellElement 
						initializeWithIcon: icon
						label: label ] ];
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
	^ self initialValueBlock value
]

{ #category : #properties }
LcsAccessorSlot >> initialValue: anObject [
	self initialValueBlock: [ anObject ]
]

{ #category : #properties }
LcsAccessorSlot >> initialValueBlock [
	^ self properties at: 'initialValueBlock' ifAbsentPut: [ self defaultInitialValueBlock]
]

{ #category : #properties }
LcsAccessorSlot >> initialValueBlock: aBlock [ 
	self properties at: 'initialValueBlock' put: aBlock
]

{ #category : #printing }
LcsAccessorSlot >> initialValueBlockSourceCode [
	^ self initialValueBlock compiledBlock sourceNode sourceCode
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
	self initialValueBlock: self defaultInitialValueBlock.
	self allowNil: false.
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
	self variableUpdatePolicy: (LcsDirectVariableUpdatePolicy newOn: self)
]

{ #category : #configuration }
LcsAccessorSlot >> makeUpdateOfVariableViaUnitOfWork [
	self variableUpdatePolicy: (LcsUnitOfWorkVariableUpdatePolicy newOn: self)
]

{ #category : #'slot model' }
LcsAccessorSlot >> newDomainClassName [
	^ self domainClass ifNil: [ ^ '<not initialized>']
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

{ #category : #printing }
LcsAccessorSlot >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' (';
		nextPutAll: self slotName displayString; 
		nextPutAll: ')'
]

{ #category : #properties }
LcsAccessorSlot >> required [
	^ self properties at: 'required' ifAbsent: [ ]
]

{ #category : #properties }
LcsAccessorSlot >> required: anObject [
	self properties at: 'required' put: anObject
]

{ #category : #magritte }
LcsAccessorSlot >> requiredDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Required';
		priority: 10;
		accessor: #'required';
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
LcsAccessorSlot >> slotDefinitionSelector [
	^ (self slotName , 'SlotDefinition') asSymbol
]

{ #category : #validation }
LcsAccessorSlot >> slotDoesNotExistMessage [
	^ 'Slot name ' , self slotName asString , ' does not exist in '
		, self domainClass name
]

{ #category : #printing }
LcsAccessorSlot >> slotTypesList [
	| stream |
	stream := WriteStream on: String new.
	self slotTypes 
		do: [ :each | stream nextPutAll: each name ] 
		separatedBy: [stream nextPutAll: ', ' ].
	^ stream contents
]

{ #category : #'slot model' }
LcsAccessorSlot >> slotVarDirectlyPut: anObject in: aDomainObject [
	aDomainObject instVarNamed: self slotName asString put: anObject

]

{ #category : #'slot model' }
LcsAccessorSlot >> slotVarPut: anObject in: aDomainObject [
	self variableUpdatePolicy slotVarPut: anObject  in: aDomainObject
]

{ #category : #'slot model' }
LcsAccessorSlot >> validate: anObject for: aDomainObject [
	self verifyType: anObject for: aDomainObject.
	(self isNilAllowed and: [self isNullObject: anObject]) ifTrue: [ ^ self ].
	self validationConditions validate: anObject context: aDomainObject
]

{ #category : #validating }
LcsAccessorSlot >> validator [
	^ LcsConditionsValidator new
]

{ #category : #accessing }
LcsAccessorSlot >> variableUpdatePolicy [
	^ variableUpdatePolicy
]

{ #category : #accessing }
LcsAccessorSlot >> variableUpdatePolicy: anObject [
	variableUpdatePolicy := anObject
]

{ #category : #'slot model' }
LcsAccessorSlot >> verifyType: anObject for: aDomainObject [
	(self isNilAllowed and: [ anObject isNil ]) ifTrue: [ ^ true ].
	self slotTypes
		detect: [ :eachClass | anObject isKindOf: eachClass ]
		ifNone: [ 
			self currentUnitOfWork removeAddOf: anObject.
			LcsInvalidSlotTypeError
				signalInvalidType: anObject
				forSlot: self
				for: aDomainObject ]
]
