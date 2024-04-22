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

{ #category : #validation }
LcsSlotModel >> addValidateConfigurationResultTo: aValidator [
	self collection do: [ :eachSlotDefintion | aValidator validate: eachSlotDefintion ]
]

{ #category : #accessing }
LcsSlotModel >> domainClass [
	^ domainClass
]

{ #category : #accessing }
LcsSlotModel >> domainClass: anObject [
	domainClass := anObject
]

{ #category : #accessing }
LcsSlotModel >> gtViewSlotDefinitionsFor: aView [
	<gtView>
	<gtClassView>
^ aView columnedList
		title: 'Slot Definitions';
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

{ #category : #model }
LcsSlotModel >> initializeModel: aDomainObject [
	self collection do: [ :eachDefintion | eachDefintion initializeModel: aDomainObject ]
]

{ #category : #initialization }
LcsSlotModel >> initializeOn: aDomainClass [ 
	self domainClass: aDomainClass
]

{ #category : #accessing }
LcsSlotModel >> parent [
	^self domainClass
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
