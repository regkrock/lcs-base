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
		'validator'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #configuration }
LcsSlotDefinition >> addSlotType: aClass [
	(self slotTypes includes: aClass) ifFalse: [ self slotTypes add: aClass ]
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

{ #category : #'application environment' }
LcsSlotDefinition >> currentUnitOfWork [
	^ #LcsApplicationEnvironment asClass currentUnitOfWork
]

{ #category : #accessing }
LcsSlotDefinition >> domainClass [
	^ self parent ifNil: [ nil class ] ifNotNil: [ self parent domainClass ]
]

{ #category : #model }
LcsSlotDefinition >> getValueIn: aDomainObject [

	^ (self currentUnitOfWork changedSlotRecordFor: aDomainObject slotNamed: self slotName)
		ifNil: [ aDomainObject instVarNamed: self slotName asString ]
		ifNotNil: [ :changedSlotRecord | changedSlotRecord newValue ]
]

{ #category : #accessing }
LcsSlotDefinition >> gtSlotDefinitionAttributes [
	^ OrderedCollection new
		add: 'domainClass' -> self domainClass;
		add: 'slotName' -> self slotName;
		add: 'slotTypes' -> self slotTypeClassNames;
		add: 'required' -> self isRequired;
		yourself
]

{ #category : #accessing }
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

{ #category : #initialization }
LcsSlotDefinition >> initialize [
	super initialize.
	self initializeSlotTypes
]

{ #category : #model }
LcsSlotDefinition >> initializeModel: aDomainObject [
	self setValueTo: self newSlotValue in: aDomainObject
]

{ #category : #initialization }
LcsSlotDefinition >> initializeSlotTypes [
	self slotTypes: OrderedCollection new
]

{ #category : #testing }
LcsSlotDefinition >> isOptional [
	^ self required ~~ true
]

{ #category : #testing }
LcsSlotDefinition >> isRequired [
	^ self required == true
]

{ #category : #model }
LcsSlotDefinition >> newSlotValue [
	^ self slotTypes any new
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

{ #category : #model }
LcsSlotDefinition >> setValueTo: anObject in: aDomainObject [
	self currentUnitOfWork setValueTo: anObject in: aDomainObject forSlot: self

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

{ #category : #validation }
LcsSlotDefinition >> validateConfiguration [
	self parent.
]

{ #category : #accessing }
LcsSlotDefinition >> validator [
	^ validator
]

{ #category : #accessing }
LcsSlotDefinition >> validator: anObject [
	validator := anObject
]
