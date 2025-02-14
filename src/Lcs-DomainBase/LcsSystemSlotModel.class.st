Class {
	#name : #LcsSystemSlotModel,
	#superclass : #LcsDomainObject,
	#instVars : [
		'slotModels'
	],
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #'instance creation' }
LcsSystemSlotModel class >> newOn: aSystem [ 
	^ self new
		parent: aSystem;
		yourself
]

{ #category : #'slot model' }
LcsSystemSlotModel class >> slotModelsSlotDefinition [
	<slotDefinition>
	^ LcsIdentityDictionarySlot new
		slotName: 'slotModels';
		yourself
]

{ #category : #'slot model' }
LcsSystemSlotModel >> addToSlotModel: aSlotModel [
	self slotModels at: aSlotModel parent put: aSlotModel
]

{ #category : #'gt view' }
LcsSystemSlotModel >> gtSystemSlotModelFor: aView [
	<gtView>
	self slotModels ifEmpty: [ ^ aView empty ].
	^ aView columnedTree 
		title: 'Slot Model';
		priority: 2.5;
		"expandUpTo: 0;"
		items: [ self gtViewSlotModelChildren ];
		children: [ :each | each children ];
		column: 'Option'
			text: [ :each | each label ]
			width: 200;
		column: 'Value' text: [ :each | each item displayString ];
		send: #item;
		yourself
]

{ #category : #'gt view' }
LcsSystemSlotModel >> gtViewSlotModelChildren [
	| children |
	children := OrderedCollection new.
	self slotModels keysAndValuesDo: [ :key :value |
		children add: (LcsSlotModelViewItem newLabel: key name item: value) ].
	^ children
]

{ #category : #testing }
LcsSystemSlotModel >> hasSlotModelFor: aDomainObject [
	^ self hasSlotModelForClass: aDomainObject class
]

{ #category : #testing }
LcsSystemSlotModel >> hasSlotModelForClass: aDomainClass [
	self slotModels at: aDomainClass ifAbsent: [ ^ false ].
	^ true
]

{ #category : #testing }
LcsSystemSlotModel >> hasSlotModels [
	^ self slotModels notEmpty
]

{ #category : #testing }
LcsSystemSlotModel >> includes: anObject [
	^ self slotModels includes: anObject
]

{ #category : #initialize }
LcsSystemSlotModel >> initialize [
	super initialize.
	self slotModels: LcsSmalltalkConfiguration identityDictionaryClass new
]

{ #category : #'slot model' }
LcsSystemSlotModel >> removeClassFromSlotModel: aDomainClass [
	self slotModels removeKey: aDomainClass ifAbsent: [ ]
]

{ #category : #'slot model' }
LcsSystemSlotModel >> removeFromSlotModel: aSlotModel [
	self slotModels removeKey: aSlotModel parent ifAbsent: [ ]
]

{ #category : #'slot model' }
LcsSystemSlotModel >> restoreSlotModel [
	LcsBaseDomainObject releaseApplicationEnvironment.
	self slotModels keysAndValuesDo: [ :eachDomainClass :eachSlotModel | eachDomainClass slotModel: eachSlotModel ]

]

{ #category : #collection }
LcsSystemSlotModel >> size [
	^ self slotModels size
]

{ #category : #accessing }
LcsSystemSlotModel >> slotModels [
	^ slotModels
]

{ #category : #accessing }
LcsSystemSlotModel >> slotModels: anObject [
	slotModels := anObject
]
