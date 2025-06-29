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
	#name : #LcsAcessorSlot,
	#superclass : #LcsBaseSlot,
	#instVars : [
		'required',
		'validator',
		'initialValueBlock',
		'variableUpdatePolicy',
		'allowNil'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LcsAcessorSlot >> _slotVarPut: anObject in: aDomainObject [
	self verifyType: anObject for: aDomainObject.
	self currentUnitOfWork
		setValueIn: aDomainObject
		slot: self
		to: anObject
]

{ #category : #configuration }
LcsAcessorSlot >> addCondition: aCondition labelled: aString [
	"Add ==aCondition== as an additional validation condition to the receiver and give it the label ==aString==. The first argument is either a block-context or any other object that responds to ==#value:== with ==true== or ==false==."

	self conditions: (self conditions
		copyWith: (Association
			key: aCondition
			value: aString))
]

{ #category : #validation }
LcsAcessorSlot >> addValidateConfigurationResultTo: aValidator [
	(self domainClass allInstVarNames includes: self slotName)
		ifFalse: [ aValidator
				add: (LcsValidatorIssueMessage newOn: self message: self slotDoesNotExistMessage) ]
]

{ #category : #accessing }
LcsAcessorSlot >> allowNil [ 
	^ allowNil
]

{ #category : #accessing }
LcsAcessorSlot >> allowNil: anObject [
	allowNil := anObject
]

{ #category : #'slot model' }
LcsAcessorSlot >> assignParent: aDomainObject to: newValue [
	newValue isDomainObject ifTrue: [
		newValue parent: aDomainObject ]
]

{ #category : #command }
LcsAcessorSlot >> beAllowNil [ 
	self allowNil: true
]

{ #category : #configuration }
LcsAcessorSlot >> beOptional [
	self required: false
]

{ #category : #configuration }
LcsAcessorSlot >> beRequired [
	self required: true
]

{ #category : #'as yet unclassified' }
LcsAcessorSlot >> changeHistoryRepresentationIn: aNewObject [
	^ aNewObject isDomainObject ifTrue: [ aNewObject uuid ] ifFalse: [ aNewObject ]
]

{ #category : #testing }
LcsAcessorSlot >> changedSlotRecordFor: aDomainObject [
	^ self currentUnitOfWork
		changedSlotRecordFor: aDomainObject
		slotNamed: self slotName
]

{ #category : #defaults }
LcsAcessorSlot >> createNewInstanceOf: aClass inContext: context [
	aClass isDomainClass
		ifTrue: [ aClass newInContext: context ]
		ifFalse: [ aClass new ]
]

{ #category : #testing }
LcsAcessorSlot >> currentSlotVarIn: aDomainObject [
	^ (self changedSlotRecordFor: aDomainObject)
		ifNil: [ self persistedSlotVarIn: aDomainObject ]
		ifNotNil: [ :changedSlotRecord | changedSlotRecord newValue ]
]

{ #category : #defaults }
LcsAcessorSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject | 
		(self slotTypes any new)
			parent: parentDomainObject;
			yourself ]
]

{ #category : #printing }
LcsAcessorSlot >> defaultInitialValueBlockSourceCode [
	^ self defaultInitialValueBlock compiledBlock sourceNode sourceCode
]

{ #category : #'slot model' }
LcsAcessorSlot >> getterSelector [
	| substring1 substring2 |
	substring1 := (self slotName at: 1) asLowercase asString.
	substring2 := self slotName asCamelCase copyFrom: 2 to: self slotName size.
	^ (substring1 , substring2) asSymbol
		
]

{ #category : #'gt views' }
LcsAcessorSlot >> gtCreateClassAndValueElementFor: aColumn [
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
LcsAcessorSlot >> gtDomainMetaFor: aView [
	<gtView>
	self parent isNil ifTrue: [ ^ aView empty ].
	^ aView explicit
		title: 'Domain Meta';
		priority: 200;
		stencil: [ (GtCoderElement forObject: self domainClass) disablePlayPage beNormalLevel ]
]

{ #category : #'gt views' }
LcsAcessorSlot >> gtSlotAttributesViewFor: aView [
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
LcsAcessorSlot >> gtSlotDefinitionAttributes [
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
LcsAcessorSlot >> gtSlotDefinitionMethodViewFor: aView [
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
LcsAcessorSlot >> gtSlotModelFor: aView [
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
LcsAcessorSlot >> gtSlotTypesViewFor: aView [
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
LcsAcessorSlot >> gtViewSlotModelChildren [
	^ {
		LcsSlotModelViewItem newLabel: 'domainClass' item: self domainClass.
		LcsSlotModelViewItem newLabel: 'slotName' item: self slotName.
		LcsSlotModelViewItem newLabel: 'slotTypes' item: self slotTypeClassNames.
		LcsSlotModelViewItem newLabel: 'required' item: self isRequired.
		}
]

{ #category : #accessing }
LcsAcessorSlot >> initialValue [
	^ self initialValueBlock value
]

{ #category : #accessing }
LcsAcessorSlot >> initialValue: anObject [
	self initialValueBlock: [ anObject ]
]

{ #category : #accessing }
LcsAcessorSlot >> initialValueBlock [
	^ initialValueBlock
]

{ #category : #accessing }
LcsAcessorSlot >> initialValueBlock: aBlock [ 
	initialValueBlock := aBlock
]

{ #category : #printing }
LcsAcessorSlot >> initialValueBlockSourceCode [
	^ self initialValueBlock compiledBlock sourceNode sourceCode
]

{ #category : #accessing }
LcsAcessorSlot >> initialValueFor: aDomainObject [
	| newValue |
	newValue := self initialValueBlock cull: aDomainObject cull: self.
	"(newValue isDomainObject and: [ self currentSystem notNil ])
		ifTrue: [ 
			self assignParent: aDomainObject to: newValue.
			self currentUnitOfWork addObject: newValue context: aDomainObject ]."
	^ newValue
]

{ #category : #initialize }
LcsAcessorSlot >> initialize [
	super initialize.
	self makeUpdateOfVariableViaUnitOfWork.
	self initialValueBlock: self defaultInitialValueBlock.
	self allowNil: false.
	self required: false.
]

{ #category : #'object initialization' }
LcsAcessorSlot >> initializeSlotValueIn: aDomainObject [
	self slotVarPut: (self initialValueFor: aDomainObject) in: aDomainObject
]

{ #category : #accessing }
LcsAcessorSlot >> initializeUnintializedSlotValueIn: aDomainObject [
	(self currentSlotVarIn: aDomainObject) ifNotNil: [ ^ self ].
	self initializeSlotValueIn: aDomainObject
]

{ #category : #accessing }
LcsAcessorSlot >> isGlobalCollectionRefenceSlot [
	^ false
]

{ #category : #accessing }
LcsAcessorSlot >> isGlobalCollectionRefenceSlotTo: aSlotName [
	^ false
]

{ #category : #testing }
LcsAcessorSlot >> isGlobalCollectionSlot [
	^ false
]

{ #category : #validation }
LcsAcessorSlot >> isInstanceVariableDefined [
	^ self domainClass allInstVarNames includes: self slotName
]

{ #category : #testing }
LcsAcessorSlot >> isLocalCollectionSlot [
	^ false
]

{ #category : #testing }
LcsAcessorSlot >> isNilAllowed [
	^ self allowNil == true
]

{ #category : #testing }
LcsAcessorSlot >> isNotRequired [
	^ self isRequired not
]

{ #category : #testing }
LcsAcessorSlot >> isNullObject: anObject [
	<TODO: 'This needs to be flushed out'> 
	^ false
]

{ #category : #testing }
LcsAcessorSlot >> isOptional [
	^ self required ~~ true
]

{ #category : #testing }
LcsAcessorSlot >> isRequired [
	^ self required == true
]

{ #category : #configuration }
LcsAcessorSlot >> makeDirectUpdateOfVariable [
	self variableUpdatePolicy: (LcsDirectVariableUpdatePolicy newOn: self)
]

{ #category : #configuration }
LcsAcessorSlot >> makeUpdateOfVariableViaUnitOfWork [
	self variableUpdatePolicy: (LcsUnitOfWorkVariableUpdatePolicy newOn: self)
]

{ #category : #'gt views' }
LcsAcessorSlot >> newDomainClassName [
	^ self domainClass ifNil: [ ^ '<not initialized>']
]

{ #category : #defaults }
LcsAcessorSlot >> newObjectWithParent: parentDomainObject [
		| newObject |
		newObject := self slotTypes any basicNew.
		parentDomainObject perform: self setterSelector with: newObject.
		^ newObject
			parent: parentDomainObject;
			initialize;
			yourself
]

{ #category : #'slot model' }
LcsAcessorSlot >> persistedSlotVarIn: aDomainObject [
	"self traceCr: 'persistedSlotVarIn: ' , aDomainObject printString."
	"aDomainObject isInAddingState ifTrue: [ ^ nil ]."
	^ aDomainObject instVarNamed: self slotName asString
]

{ #category : #printing }
LcsAcessorSlot >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' (';
		nextPutAll: self slotName displayString; 
		nextPutAll: ')'
]

{ #category : #accessing }
LcsAcessorSlot >> required [
	^ required
]

{ #category : #accessing }
LcsAcessorSlot >> required: anObject [
	required := anObject
]

{ #category : #magritte }
LcsAcessorSlot >> requiredDescription [
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
LcsAcessorSlot >> setUpPendingAddOf: aDomainObject in: aUnitOfWork [
	"collection slots need to implement logic here"
]

{ #category : #private }
LcsAcessorSlot >> setUpPendingDeleteOf: aDomainObject in: aUnitOfWork [
	"collection slots need to implement logic here"
]

{ #category : #'slot model' }
LcsAcessorSlot >> setterSelector [
	^ (self getterSelector , ':') asSymbol
		
]

{ #category : #'slot model' }
LcsAcessorSlot >> slotDefinitionSelector [
	^ (self slotName , 'SlotDefinition') asSymbol
]

{ #category : #validation }
LcsAcessorSlot >> slotDoesNotExistMessage [
	^ 'Slot name ' , self slotName asString , ' does not exist in '
		, self domainClass name
]

{ #category : #printing }
LcsAcessorSlot >> slotTypesList [
	| stream |
	stream := WriteStream on: String new.
	self slotTypes 
		do: [ :each | stream nextPutAll: each name ] 
		separatedBy: [stream nextPutAll: ', ' ].
	^ stream contents
]

{ #category : #'slot model' }
LcsAcessorSlot >> slotVarDirectlyPut: anObject in: aDomainObject [
	aDomainObject instVarNamed: self slotName asString put: anObject

]

{ #category : #'slot model' }
LcsAcessorSlot >> slotVarPut: anObject in: aDomainObject [
	self variableUpdatePolicy slotVarPut: anObject  in: aDomainObject
]

{ #category : #'slot model' }
LcsAcessorSlot >> validate: anObject for: aDomainObject [
	self verifyType: anObject for: aDomainObject.
	(self isNilAllowed and: [self isNullObject: anObject]) ifTrue: [ ^ self ].
	self validationConditions validate: anObject context: aDomainObject
]

{ #category : #validating }
LcsAcessorSlot >> validator [
	^ LcsConditionsValidator new
]

{ #category : #accessing }
LcsAcessorSlot >> variableUpdatePolicy [
	^ variableUpdatePolicy
]

{ #category : #accessing }
LcsAcessorSlot >> variableUpdatePolicy: anObject [
	variableUpdatePolicy := anObject
]

{ #category : #'slot model' }
LcsAcessorSlot >> verifyType: anObject for: aDomainObject [
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
