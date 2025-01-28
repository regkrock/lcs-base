"
This class and its subclasses define a slot:

slotName - this is the name of the slot and is the same as the instvarName. 
"
Class {
	#name : #LcsSlotDefinition,
	#superclass : #LcsApplicationObject,
	#instVars : [
		'slotName',
		'parent',
		'slotTypes',
		'required',
		'validator',
		'initialValueBlock'
	],
	#category : #'Lcs-SystemManagement-Core'
}

{ #category : #'slot model' }
LcsSlotDefinition >> _slotVarPut: anObject in: aDomainObject [
	self verifyType: anObject.
	self currentUnitOfWork
		setValueIn: aDomainObject
		slot: self
		to: anObject
]

{ #category : #configuration }
LcsSlotDefinition >> addSlotType: aClass [
	(self slotTypes includes: aClass) ifFalse: [ self slotTypes add: aClass ]
]

{ #category : #validation }
LcsSlotDefinition >> addValidateConfigurationResultTo: aValidator [
	(self domainClass allInstVarNames includes: self slotName)
		ifFalse: [ aValidator
				add: (LcsValidatorIssueMessage newOn: self message: self slotDoesNotExistMessage) ]
]

{ #category : #'as yet unclassified' }
LcsSlotDefinition >> allowNil [
	self addSlotType: UndefinedObject.
	self initialValue: nil
]

{ #category : #configuration }
LcsSlotDefinition >> beOptional [
	self required: false
]

{ #category : #configuration }
LcsSlotDefinition >> beRequired [
	self required: true
]

{ #category : #configuration }
LcsSlotDefinition >> clearSlotTypes [
	self slotTypes removeAll.
]

{ #category : #defaults }
LcsSlotDefinition >> createNewInstanceOf: aClass inContext: context [
	aClass isDomainClass
		ifTrue: [ aClass newInContext: context ]
		ifFalse: [ aClass new ]
]

{ #category : #'slot model' }
LcsSlotDefinition >> currentSlotVarIn: aDomainObject [

	^ (self currentUnitOfWork changedSlotRecordFor: aDomainObject slotNamed: self slotName)
		ifNil: [ self persistedSlotVarIn: aDomainObject]
		ifNotNil: [ :changedSlotRecord | changedSlotRecord newValue ]
]

{ #category : #defaults }
LcsSlotDefinition >> defaultInitialValueBlock [
	^ [ self slotTypes any new ]
]

{ #category : #'slot model' }
LcsSlotDefinition >> domainClass [
	^ self parent domainClass
]

{ #category : #'slot model' }
LcsSlotDefinition >> getterSelector [
	| substring1 substring2 |
	substring1 := (self slotName at: 1) asLowercase asString.
	substring2 := self slotName asCamelCase copyFrom: 2 to: self slotName size.
	^ (substring1 , substring2) asSymbol
		
]

{ #category : #'gt view' }
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

{ #category : #'gt view' }
LcsSlotDefinition >> gtDomainMetaFor: aView [
	<gtView>
	^ aView explicit
		title: 'Domain Meta';
		priority: 200;
		stencil: [ (GtCoderElement forObject: self domainClass) disablePlayPage beNormalLevel ]
]

{ #category : #'gt view' }
LcsSlotDefinition >> gtSlotDefinitionAttributes [
	^ OrderedCollection new
		add: 'slotDefinition' -> self;
		add: 'slotDefinitionClass' -> self class;
		add: 'domainClass' -> self newDomainClassName;
		add: 'slotName' -> self slotName;
		add: 'slotTypes' -> self slotTypes;
		add: 'required' -> self isRequired;
		yourself
]

{ #category : #'gt view' }
LcsSlotDefinition >> gtSlotDefinitionViewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Attributes';
		priority: 10;
		items: [ self gtSlotDefinitionAttributes ];
		column: 'Option' 
			text: #key 
			width: 200;
		column: 'Value' do: [ :aColumn | self gtCreateClassAndValueElementFor: aColumn ];
		send: #value;
		yourself
]

{ #category : #'gt view' }
LcsSlotDefinition >> gtSlotModelFor: aView [
	<gtView>
	^ aView forward
		title: 'Slot Model';
		priority: 200;
		object: [ self parent ];
		view: #gtRawFor:;
		yourself
]

{ #category : #'gt view' }
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

{ #category : #'gt view' }
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

{ #category : #accessing }
LcsSlotDefinition >> initialValueFor: aDomainObject [
	| newValue |
	newValue := self initialValueBlock cull: aDomainObject.
	(newValue isDomainObject and: [ self currentSystem notNil ])
		ifNotNil: [ self currentUnitOfWork addObject: newValue context: aDomainObject ].
	^newValue
]

{ #category : #initialize }
LcsSlotDefinition >> initialize [
	super initialize.
	self initializeSlotTypes.
	self initialValueBlock: self defaultInitialValueBlock
]

{ #category : #initialize }
LcsSlotDefinition >> initializeSlotTypes [
	self slotTypes: OrderedCollection new
]

{ #category : #accessing }
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

{ #category : #'slot model' }
LcsSlotDefinition >> label [
	^self labelForSelector: self slotName
]

{ #category : #'gt view' }
LcsSlotDefinition >> newDomainClassName [
	self parent ifNil: [ ^ self parent class name].
	^self parent domainClass
]

{ #category : #accessing }
LcsSlotDefinition >> parent [
	^ parent
]

{ #category : #accessing }
LcsSlotDefinition >> parent: anObject [
	parent := anObject
]

{ #category : #'slot model' }
LcsSlotDefinition >> persistedSlotVarIn: aDomainObject [

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

{ #category : #defaults }
LcsSlotDefinition >> slotClass [
	^ self slotTypes any
]

{ #category : #validation }
LcsSlotDefinition >> slotDoesNotExistMessage [
	^ 'Slot name ' , self slotName asString , ' does not exist in '
		, self domainClass name
]

{ #category : #accessing }
LcsSlotDefinition >> slotName [
	^ slotName
]

{ #category : #accessing }
LcsSlotDefinition >> slotName: anObject [
	slotName := anObject
]

{ #category : #'gt view' }
LcsSlotDefinition >> slotTypeClassNames [
	| stream |
	stream := WriteStream on: String new.
	self slotTypes do: [ :eachClass |
		stream nextPutAll: (
			eachClass isClass 
				ifTrue: [ eachClass name displayString ] 
				ifFalse: [ eachClass printString ])  ] separatedBy: [ stream nextPutAll: ', '].
	^stream contents
]

{ #category : #accessing }
LcsSlotDefinition >> slotTypes [
	^ slotTypes
]

{ #category : #accessing }
LcsSlotDefinition >> slotTypes: anObject [
	slotTypes := anObject
]

{ #category : #'slot model' }
LcsSlotDefinition >> slotVarDirectlyPut: anObject in: aDomainObject [
	aDomainObject instVarNamed: self slotName asString put: anObject

]

{ #category : #'slot model' }
LcsSlotDefinition >> slotVarPut: anObject in: aDomainObject [
	self _slotVarPut: anObject  in: aDomainObject
]

{ #category : #accessing }
LcsSlotDefinition >> validator [
	^ validator
]

{ #category : #accessing }
LcsSlotDefinition >> validator: anObject [
	validator := anObject
]

{ #category : #'slot model' }
LcsSlotDefinition >> verifyType: anObject [
	self slotTypes
		detect: [ :eachClass | anObject isKindOf: eachClass ]
		ifNone: [ 
			self currentUnitOfWork removeAddOf: anObject.
			LcsInvalidSlotType newInvalidParentTypeObject: anObject forSlot: self ]
]
