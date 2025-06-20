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
	#name : #LcsSlotDefinition,
	#superclass : #LcsBaseSlotDefinition,
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
LcsSlotDefinition >> _slotVarPut: anObject in: aDomainObject [
	self verifyType: anObject for: aDomainObject.
	self currentUnitOfWork
		setValueIn: aDomainObject
		slot: self
		to: anObject
]

{ #category : #configuration }
LcsSlotDefinition >> addCondition: aCondition labelled: aString [
	"Add ==aCondition== as an additional validation condition to the receiver and give it the label ==aString==. The first argument is either a block-context or any other object that responds to ==#value:== with ==true== or ==false==."

	self conditions: (self conditions
		copyWith: (Association
			key: aCondition
			value: aString))
]

{ #category : #validation }
LcsSlotDefinition >> addValidateConfigurationResultTo: aValidator [
	(self domainClass allInstVarNames includes: self slotName)
		ifFalse: [ aValidator
				add: (LcsValidatorIssueMessage newOn: self message: self slotDoesNotExistMessage) ]
]

{ #category : #accessing }
LcsSlotDefinition >> allowNil [ 
	^ allowNil
]

{ #category : #accessing }
LcsSlotDefinition >> allowNil: anObject [
	allowNil := anObject
]

{ #category : #'slot model' }
LcsSlotDefinition >> assignParent: aDomainObject to: newValue [
	newValue isDomainObject ifTrue: [
		newValue parent: aDomainObject ]
]

{ #category : #command }
LcsSlotDefinition >> beAllowNil [ 
	self allowNil: true
]

{ #category : #configuration }
LcsSlotDefinition >> beOptional [
	self required: false
]

{ #category : #configuration }
LcsSlotDefinition >> beRequired [
	self required: true
]

{ #category : #'as yet unclassified' }
LcsSlotDefinition >> changeHistoryRepresentationIn: aNewObject [
	^ aNewObject isDomainObject ifTrue: [ aNewObject uuid ] ifFalse: [ aNewObject ]
]

{ #category : #testing }
LcsSlotDefinition >> changedSlotRecordFor: aDomainObject [
	^ self currentUnitOfWork
		changedSlotRecordFor: aDomainObject
		slotNamed: self slotName
]

{ #category : #defaults }
LcsSlotDefinition >> createNewInstanceOf: aClass inContext: context [
	aClass isDomainClass
		ifTrue: [ aClass newInContext: context ]
		ifFalse: [ aClass new ]
]

{ #category : #testing }
LcsSlotDefinition >> currentSlotVarIn: aDomainObject [
	^ (self changedSlotRecordFor: aDomainObject)
		ifNil: [ self persistedSlotVarIn: aDomainObject ]
		ifNotNil: [ :changedSlotRecord | changedSlotRecord newValue ]
]

{ #category : #defaults }
LcsSlotDefinition >> defaultInitialValueBlock [
	^ [ :parentDomainObject | 
		(self slotTypes any new)
			parent: parentDomainObject;
			yourself ]
]

{ #category : #printing }
LcsSlotDefinition >> defaultInitialValueBlockSourceCode [
	^ self defaultInitialValueBlock compiledBlock sourceNode sourceCode
]

{ #category : #'slot model' }
LcsSlotDefinition >> getterSelector [
	| substring1 substring2 |
	substring1 := (self slotName at: 1) asLowercase asString.
	substring2 := self slotName asCamelCase copyFrom: 2 to: self slotName size.
	^ (substring1 , substring2) asSymbol
		
]

{ #category : #'gt views' }
LcsSlotDefinition >> gtCreateClassAndValueElementFor: aColumn [
	^ aColumn
		cellStencil: [ BrHorizontalPane new
				hMatchParent;
				vFitContent;
				alignCenter ];
		dataBinder: [ :itemElement :aNode | 
			| nodeIcon |
			Transcript 
				show: 'Item: ';
				show: itemElement printString; tab; 
				show: ' Node: ';
				show: aNode printString; 
				cr.
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
LcsSlotDefinition >> gtDomainMetaFor: aView [
	<gtView>
	self parent isNil ifTrue: [ ^ aView empty ].
	^ aView explicit
		title: 'Domain Meta';
		priority: 200;
		stencil: [ (GtCoderElement forObject: self domainClass) disablePlayPage beNormalLevel ]
]

{ #category : #'gt views' }
LcsSlotDefinition >> gtSlotAttributesViewFor: aView [
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
LcsSlotDefinition >> gtSlotDefinitionAttributes [
	^ OrderedCollection new
		add: 'slotDefinition' -> self;
		add: 'slotDefinitionClass' -> self class;
		add: 'domainClass' -> self newDomainClassName;
		add: 'slotName' -> self slotName;
		add: 'slotTypes' -> self slotTypesList;
		add: 'required' -> self isRequired;
		add: 'initialValueBlock' -> self initialValueBlockSourceCode;
		yourself
]

{ #category : #'gt views' }
LcsSlotDefinition >> gtSlotDefinitionMethodViewFor: aView [
	<gtView>

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
LcsSlotDefinition >> gtSlotModelFor: aView [
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
LcsSlotDefinition >> gtSlotTypesViewFor: aView [
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
LcsSlotDefinition >> gtViewSlotModelChildren [
	^ {
		LcsSlotModelViewItem newLabel: 'domainClass' item: self domainClass.
		LcsSlotModelViewItem newLabel: 'slotName' item: self slotName.
		LcsSlotModelViewItem newLabel: 'slotTypes' item: self slotTypeClassNames.
		LcsSlotModelViewItem newLabel: 'required' item: self isRequired.
		}
]

{ #category : #accessing }
LcsSlotDefinition >> initialValue [
	^ self initialValueBlock value
]

{ #category : #accessing }
LcsSlotDefinition >> initialValue: anObject [
	self initialValueBlock: [ anObject ]
]

{ #category : #accessing }
LcsSlotDefinition >> initialValueBlock [
	^ initialValueBlock
]

{ #category : #accessing }
LcsSlotDefinition >> initialValueBlock: aBlock [ 
	initialValueBlock := aBlock
]

{ #category : #printing }
LcsSlotDefinition >> initialValueBlockSourceCode [
	^ self initialValueBlock compiledBlock sourceNode sourceCode
]

{ #category : #accessing }
LcsSlotDefinition >> initialValueFor: aDomainObject [
	| newValue |
	newValue := self initialValueBlock cull: aDomainObject cull: self.
	"(newValue isDomainObject and: [ self currentSystem notNil ])
		ifTrue: [ 
			self assignParent: aDomainObject to: newValue.
			self currentUnitOfWork addObject: newValue context: aDomainObject ]."
	^ newValue
]

{ #category : #initialize }
LcsSlotDefinition >> initialize [
	super initialize.
	self initializeSlotTypes.
	self makeUpdateOfVariableViaUnitOfWork.
	self initialValueBlock: self defaultInitialValueBlock.
	self allowNil: false.
	self required: false.
]

{ #category : #'object initialization' }
LcsSlotDefinition >> initializeSlotValueIn: aDomainObject [
	self slotVarPut: (self initialValueFor: aDomainObject) in: aDomainObject
]

{ #category : #accessing }
LcsSlotDefinition >> initializeUnintializedSlotValueIn: aDomainObject [
	(self currentSlotVarIn: aDomainObject) ifNotNil: [ ^ self ].
	self initializeSlotValueIn: aDomainObject
]

{ #category : #accessing }
LcsSlotDefinition >> isGlobalCollectionRefenceSlot [
	^ false
]

{ #category : #accessing }
LcsSlotDefinition >> isGlobalCollectionRefenceSlotTo: aSlotName [
	^ false
]

{ #category : #testing }
LcsSlotDefinition >> isGlobalCollectionSlot [
	^ false
]

{ #category : #validation }
LcsSlotDefinition >> isInstanceVariableDefined [
	^ self domainClass allInstVarNames includes: self slotName
]

{ #category : #testing }
LcsSlotDefinition >> isLocalCollectionSlot [
	^ false
]

{ #category : #testing }
LcsSlotDefinition >> isNilAllowed [
	^ self allowNil == true
]

{ #category : #testing }
LcsSlotDefinition >> isNotRequired [
	^ self isRequired not
]

{ #category : #testing }
LcsSlotDefinition >> isOptional [
	^ self required ~~ true
]

{ #category : #testing }
LcsSlotDefinition >> isRequired [
	^ self required == true
]

{ #category : #configuration }
LcsSlotDefinition >> makeDirectUpdateOfVariable [
	self variableUpdatePolicy: (LcsDirectVariableUpdatePolicy newOn: self)
]

{ #category : #configuration }
LcsSlotDefinition >> makeUpdateOfVariableViaUnitOfWork [
	self variableUpdatePolicy: (LcsUnitOfWorkVariableUpdatePolicy newOn: self)
]

{ #category : #'gt views' }
LcsSlotDefinition >> newDomainClassName [
	^ self domainClass ifNil: [ ^ '<not initialized>']
]

{ #category : #defaults }
LcsSlotDefinition >> newObjectWithParent: parentDomainObject [
		| newObject |
		newObject := self slotTypes any basicNew.
		parentDomainObject perform: self setterSelector with: newObject.
		^ newObject
			parent: parentDomainObject;
			initialize;
			yourself
]

{ #category : #'slot model' }
LcsSlotDefinition >> persistedSlotVarIn: aDomainObject [
	"self traceCr: 'persistedSlotVarIn: ' , aDomainObject printString."
	"aDomainObject isInAddingState ifTrue: [ ^ nil ]."
	^ aDomainObject instVarNamed: self slotName asString
]

{ #category : #printing }
LcsSlotDefinition >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' (';
		nextPutAll: self slotName displayString; 
		nextPutAll: ')'
]

{ #category : #accessing }
LcsSlotDefinition >> required [
	^ required
]

{ #category : #accessing }
LcsSlotDefinition >> required: anObject [
	required := anObject
]

{ #category : #private }
LcsSlotDefinition >> setUpPendingAddOf: aDomainObject in: aUnitOfWork [
	"collection slots need to implement logic here"
]

{ #category : #private }
LcsSlotDefinition >> setUpPendingDeleteOf: aDomainObject in: aUnitOfWork [
	"collection slots need to implement logic here"
]

{ #category : #'slot model' }
LcsSlotDefinition >> setterSelector [
	^ (self getterSelector , ':') asSymbol
		
]

{ #category : #'slot model' }
LcsSlotDefinition >> slotDefinitionSelector [
	^ (self slotName , 'SlotDefinition') asSymbol
]

{ #category : #validation }
LcsSlotDefinition >> slotDoesNotExistMessage [
	^ 'Slot name ' , self slotName asString , ' does not exist in '
		, self domainClass name
]

{ #category : #printing }
LcsSlotDefinition >> slotTypesList [
	| stream |
	stream := WriteStream on: String new.
	self slotTypes 
		do: [ :each | stream nextPutAll: each name ] 
		separatedBy: [stream nextPutAll: ', ' ].
	^ stream contents
]

{ #category : #'slot model' }
LcsSlotDefinition >> slotVarDirectlyPut: anObject in: aDomainObject [
	aDomainObject instVarNamed: self slotName asString put: anObject

]

{ #category : #'slot model' }
LcsSlotDefinition >> slotVarPut: anObject in: aDomainObject [
	self variableUpdatePolicy slotVarPut: anObject  in: aDomainObject
]

{ #category : #validating }
LcsSlotDefinition >> validator [
	^ LcsConditionsValidator new
]

{ #category : #accessing }
LcsSlotDefinition >> variableUpdatePolicy [
	^ variableUpdatePolicy
]

{ #category : #accessing }
LcsSlotDefinition >> variableUpdatePolicy: anObject [
	variableUpdatePolicy := anObject
]

{ #category : #'slot model' }
LcsSlotDefinition >> verifyType: anObject for: aDomainObject [
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
