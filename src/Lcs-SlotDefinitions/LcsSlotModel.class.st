Class {
	#name : #LcsSlotModel,
	#superclass : #LcsCollection,
	#instVars : [
		'domainClass'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #configuration }
LcsSlotModel class >> collectionClass [
	^ LcsSmalltalkConfiguration symbolDictionaryClass
]

{ #category : #'instance creation' }
LcsSlotModel class >> newOn: aDomainClass [

	^ self new 
		initializeOn: aDomainClass;
		yourself
]

{ #category : #slots }
LcsSlotModel >> addSlotDefinition: aSlotDefinition [

	aSlotDefinition parent: self.
	^ self collection at: aSlotDefinition slotName put: aSlotDefinition
]

{ #category : #model }
LcsSlotModel >> addSlotDefinitionsTo: aCollection [
	self collection keysAndValuesDo: [ :eachSlotName :eachSlotDefinition |
		aCollection detect: [ :each | each slotName = eachSlotName ]
			ifNone: [ aCollection add: eachSlotDefinition ] ].
	self domainClass == LcsDomainObject
		ifFalse: [ self superClassSlotModel addSlotDefinitionsTo: aCollection ]
]

{ #category : #validation }
LcsSlotModel >> addValidateConfigurationResultTo: aValidator [
	self collection do: [ :eachSlotDefintion | aValidator validate: eachSlotDefintion ]
]

{ #category : #model }
LcsSlotModel >> allSlotDefinitions [
	| allSlotDefinitions |
	allSlotDefinitions := OrderedCollection new.
	self addSlotDefinitionsTo:allSlotDefinitions.
	^ allSlotDefinitions
]

{ #category : #accessing }
LcsSlotModel >> domainClass [
	^ domainClass
]

{ #category : #accessing }
LcsSlotModel >> domainClass: anObject [
	domainClass := anObject
]

{ #category : #'gt view' }
LcsSlotModel >> gtViewSlotDefinitionsFor: aView [
	<gtView>
	<gtClassView>
^ aView columnedList
		title: 'Domain Slot Definitions';
		priority: 10;
		items: [ self collection values ];
		"children: [ :each | (each isAssociation ifTrue: [ each value ] ifFalse: [ each ]) moduleViewChildren ];"
		column: 'Name' text: [ :each | each slotName ];
		column: 'Class' text: [ :each | each class name ];
		yourself

]

{ #category : #'gt view' }
LcsSlotModel >> gtViewSlotModelChildren [
	| children |
	children := OrderedCollection new.
	self collection keysAndValuesDo: [ :key :value |
		children add: (LcsSlotModelViewItem newLabel: key item: value)].
	^ children
]

{ #category : #initialize }
LcsSlotModel >> initializeOn: aDomainClass [ 
	self domainClass: aDomainClass.
	self parent: aDomainClass
]

{ #category : #model }
LcsSlotModel >> initializeSlotValuesIn: aDomainObject [
	self allSlotDefinitions do: [ :eachDefintion | eachDefintion initializeSlotValueIn: aDomainObject ]
]

{ #category : #slots }
LcsSlotModel >> slotDefinitionNamed: aSlotName [
	| slotDefinition |
	slotDefinition := self collection at: aSlotName ifAbsent: [ 
		self domainClass superclass isDomainClass 
			ifTrue: [ self domainClass superclass slotDefinitionNamed: aSlotName ]
			ifFalse: [ nil ] ].
	^ slotDefinition ifNil: [
		LcsSlotDoesNotExistError signal: ('Slot ' , aSlotName printString  , ' not defined in ' , self domainClass name printString) ]
]

{ #category : #model }
LcsSlotModel >> superClassSlotModel [
	^ self domainClass superclass slotModel
]
