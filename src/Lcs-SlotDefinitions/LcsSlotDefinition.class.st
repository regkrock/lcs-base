"
This class and its subclasses define a slot:

slotName - this is the name of the slot and is the same as the instvarName. 
"
Class {
	#name : #LcsSlotDefinition,
	#superclass : #LcsObject,
	#instVars : [
		'slotName',
		'parent',
		'slotTypes',
		'required',
		'validator',
		'initialValueBlock'
	],
	#category : #'Lcs-SlotDefinitions'
}

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

{ #category : #'application environment' }
LcsSlotDefinition >> currentUnitOfWork [
	^ #LcsApplicationEnvironment asClass currentUnitOfWork
]

{ #category : #defaults }
LcsSlotDefinition >> defaultInitialValueBlock [
	^ [ self slotTypes any new ]
]

{ #category : #'slot model' }
LcsSlotDefinition >> domainClass [
	^ self parent domainClass
]

{ #category : #'gt view' }
LcsSlotDefinition >> domainClassName [
	self parent ifNil: [ ^ self parent class name].
	^self parent domainClass
]

{ #category : #'slot model' }
LcsSlotDefinition >> getValueIn: aDomainObject [

	^ (self currentUnitOfWork changedSlotRecordFor: aDomainObject slotNamed: self slotName)
		ifNil: [ aDomainObject instVarNamed: self slotName asString ]
		ifNotNil: [ :changedSlotRecord | changedSlotRecord newValue ]
]

{ #category : #'as yet unclassified' }
LcsSlotDefinition >> getterSelector [
	| substring1 substring2 |
	substring1 := (self slotName at: 1) asLowercase asString.
	substring2 := self slotName asCamelCase copyFrom: 2 to: self slotName size.
	^ (substring1 , substring2) asSymbol
		
]

{ #category : #'gt view' }
LcsSlotDefinition >> gtSlotDefinitionAttributes [
	^ OrderedCollection new
		add: 'domainClass' -> self domainClassName;
		add: 'slotName' -> self slotName;
		add: 'slotTypes' -> self slotTypeClassNames;
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
		column: 'Value'
			text: [ :each | each value displayString ];
		send: #value;
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
	self setValueTo: (self initialValueFor: aDomainObject) in: aDomainObject
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

{ #category : #'as yet unclassified' }
LcsSlotDefinition >> label [
	^self labelForSelector: self slotName
]

{ #category : #accessing }
LcsSlotDefinition >> parent [
	^ parent
]

{ #category : #accessing }
LcsSlotDefinition >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
LcsSlotDefinition >> required [
	^ required
]

{ #category : #accessing }
LcsSlotDefinition >> required: anObject [
	required := anObject
]

{ #category : #'slot model' }
LcsSlotDefinition >> setValueTo: anObject in: aDomainObject [
	self currentUnitOfWork setValueTo: anObject in: aDomainObject forSlot: self
]

{ #category : #'as yet unclassified' }
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
		stream nextPutAll: eachClass name displayString] separatedBy: [ stream nextPutAll: ', '].
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

{ #category : #accessing }
LcsSlotDefinition >> validator [
	^ validator
]

{ #category : #accessing }
LcsSlotDefinition >> validator: anObject [
	validator := anObject
]
