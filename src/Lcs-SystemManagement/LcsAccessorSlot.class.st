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

{ #category : #configuration }
LcsAccessorSlot class >> domainObjectParameters [
	^ #('domainObject' 'slot')
]

{ #category : #configuration }
LcsAccessorSlot class >> slotTransformBlockParameters [
	^ #('value' 'slot')
]

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
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
"		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique slot name of at least two characters in length';
		addCondition: [ :aValue | (existingInstvarNames includes: aValue asString trim asSymbol) not ] labelled: 'Slot already exists';"
		"addCondition: [ :aValue | aValue trim isEmpty  ] labelled: 'Enter a unique slot name of at least two characters in length';"
		"addCondition: [ :aValue | aValue trim isEmpty  ] labelled: 'Enter a unique slot name of at least two characters in length';"
		beRequired

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
LcsAccessorSlot >> domainObjectParameters [
	^ self class domainObjectParameters
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
LcsAccessorSlot >> gtMagritteFor: aView [
	^ (super gtMagritteFor: aView)
		actionUpdateButton
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
			yourself.
	collection addAll: self properties associations copy.
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
		accessor: (MAPluggableAccessor
				read: [ :model | 
					model 
						innerSourceCodeOfBlock: #initialValueBlock 
						in: model
						parameters: LcsAccessorSlot domainObjectParameters ]
				write: [ :model :string | 
					model
						replaceBlock: #initialValueBlock
						with: string
						in: model
						parameters: LcsAccessorSlot domainObjectParameters ]);
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
	self initialValueBlock: self defaultInitialValueBlock.
	self prevalidationTransformBlock: self defaultPrevalidationTransformBlock.
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

{ #category : #'block support' }
LcsAccessorSlot >> innerSourceCodeOfBlock: aBlockAccessor in: model parameters: anArray [
	^ LcsBlockSourceConverter innerSourceCodeOf: (model perform: aBlockAccessor asSymbol) parameters: anArray
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

{ #category : #properties }
LcsAccessorSlot >> prevalidationTransformBlock [
	^ self propertyAt: 'prevalidationTransformBlock'
]

{ #category : #properties }
LcsAccessorSlot >> prevalidationTransformBlock: aBlock [
	self propertyAt: 'prevalidationTransformBlock' put: aBlock
]

{ #category : #margritte }
LcsAccessorSlot >> prevalidationTransformBlockDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Prevalidation Transform Block [ :value :slot | ';
		priority: 11;
		accessor: (MAPluggableAccessor 
						read: [ :model | 
							model 
								innerSourceCodeOfBlock: #prevalidationTransformBlock 
								in: model 
								parameters: LcsAccessorSlot slotTransformBlockParameters]
						write: [ :model :string | 
							model 
								replaceBlock: #prevalidationTransformBlock 
								with: string 
								in: model 
								parameters: LcsAccessorSlot slotTransformBlockParameters]);
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : #printing }
LcsAccessorSlot >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' (';
		nextPutAll: self slotName displayString; 
		nextPutAll: ')'
]

{ #category : #'block support' }
LcsAccessorSlot >> replaceBlock: aBlockAccessor with: code in: aSlot parameters: anArray [
	| currentBlock newBlock |
	currentBlock := aSlot perform: aBlockAccessor asSymbol.
	newBlock := LcsBlockSourceConverter blockWithInnerSourceCode: code replacing: currentBlock parameters: anArray.
	aSlot perform: (aBlockAccessor , ':') asSymbol with: newBlock
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

{ #category : #configuration }
LcsAccessorSlot >> slotTransformBlockParameters [
	^ self class slotTransformBlockParameters
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
	| transformedObject |
	transformedObject := self prevalidationTransformBlock cull: anObject cull: self.

	self variableUpdatePolicy slotVarPut: transformedObject in: aDomainObject
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
