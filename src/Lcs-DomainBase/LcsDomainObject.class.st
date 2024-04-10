Class {
	#name : #LcsDomainObject,
	#superclass : #LcsObject,
	#instVars : [
		'parent'
	],
	#classInstVars : [
		'SlotDefinitions',
		'SlotModel'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #'slot model' }
LcsDomainObject class >> addSlotDefinitions [
	self slotDefinitionMethods do: [ :eachPragma | 
			self slotModel addSlotDefinition: (self perform: eachPragma methodSelector) ]
]

{ #category : #'unit of work' }
LcsDomainObject class >> addToUnitOfWork: newObject [
	self currentUnitOfWork addObject: newObject
]

{ #category : #'application environment' }
LcsDomainObject class >> currentUnitOfWork [
	^ LcsApplicationEnvironment currentUnitOfWork
]

{ #category : #'gt view' }
LcsDomainObject class >> gtViewSlotDefinitionsFor: aView [
	<gtView>
	<gtClassView>
	self slotModel ifNil: [ 
		^ aView list
			title: 'Slot Definitions';
			priority: 10;
			items: [ Array with: 'Not initialized' ];
			yourself].	
	^ aView forward
		title: 'Slot Definitions';
		priority: 99;
		object: [ self slotModel ];
		view: #gtViewSlotDefinitionsFor:;
		yourself
		
]

{ #category : #testing }
LcsDomainObject class >> hasNoninitializedApplicationEnvironment [
	^ self isSlotModelReleased
]

{ #category : #'application environment' }
LcsDomainObject class >> initializeApplicationEnvironment [
]

{ #category : #'slot model' }
LcsDomainObject class >> initializeSlotModel [
	self slotModel: (LcsSlotModel newOn: self).
	self currentSystem addToSlotModel: self slotModel.
	self addSlotDefinitions
]

{ #category : #testing }
LcsDomainObject class >> isSlotModelReleased [
	self slotModel notNil ifTrue: [ ^ false ].
	self subclasses do: [ :each | each isSlotModelReleased ].
	^ true
]

{ #category : #'instance creation\t' }
LcsDomainObject class >> new [
	| newObject |
	newObject := self basicNew initialize.
	self currentSystem ifNotNil: [ self addToUnitOfWork: newObject ].
	^ newObject
]

{ #category : #'application environment' }
LcsDomainObject class >> releaseApplicationEnvironment [
	self releaseSlotModel
]

{ #category : #'slot model' }
LcsDomainObject class >> releaseSlotModel [
	self slotModel: nil.
	self subclassesDo: [ :each | each releaseSlotModel ]
]

{ #category : #'slot model' }
LcsDomainObject class >> restorelotModel [
	self initializeSlotModel
]

{ #category : #'slot model' }
LcsDomainObject class >> slotDefinitionMethods [
	^ Pragma allNamed: 'slotDefinition' in: self class
]

{ #category : #'slot model' }
LcsDomainObject class >> slotDefinitionNamed: aString [ 
	self slotModel ifNil: [ ^ LcsSlotModelNotInitializedError signal: ('Slot Definitions not initialized in ' , self name) ].
	^ self slotModel slotDefinitionNamed: aString
]

{ #category : #accessing }
LcsDomainObject class >> slotModel [
	^ SlotModel
]

{ #category : #accessing }
LcsDomainObject class >> slotModel: aSlotModel [
	SlotModel := aSlotModel
]

{ #category : #validation }
LcsDomainObject >> addValidateConfigurationResultTo: aValidator [
	self isIncludedInSystemDomainClasses
		ifTrue: [self slotModel class name = #LcsSlotModel
					ifFalse: [ aValidator addIssueMessage: 'Slot Model not defined for ' , self className ]]
		ifFalse: [
			self slotModel notNil
				ifTrue: [ aValidator addIssueMessage: 'Slot Model is defined but not in the system model collection  ' ]].
	aValidator validate: self slotModel
]

{ #category : #'application environment' }
LcsDomainObject >> applicationEnvironment [
	^ self parent applicationEnvironment
]

{ #category : #'unit of work' }
LcsDomainObject >> currentUnitOfWork [
	^ self parent currentUnitOfWork
]

{ #category : #'unit of work' }
LcsDomainObject >> delete [

	self currentUnitOfWork deleteObject: self
]

{ #category : #'slot definitions' }
LcsDomainObject >> getValueOfSlotNamed: aSlotName [
	^ (self slotDefinitionNamed: aSlotName) getValueIn: self
]

{ #category : #'gt view' }
LcsDomainObject >> gtViewSlotDefinitionsFor: aView [
	<gtView>
	<gtClassView>
	^ self class gtViewSlotDefinitionsFor: aView
]

{ #category : #validation }
LcsDomainObject >> isIncludedInSystemDomainClasses [
	^ self currentSystem isIncludedInSystemDomainClasses: self
]

{ #category : #accessing }
LcsDomainObject >> parent [
	^ parent
]

{ #category : #accessing }
LcsDomainObject >> parent: anObject [
	parent := anObject
]

{ #category : #'slot definitions' }
LcsDomainObject >> setValueOfSlotNamed: aSlotName to: onObject [
	(self slotDefinitionNamed: aSlotName) setValueTo: onObject in: self
]

{ #category : #'slot definitions' }
LcsDomainObject >> slotDefinitionNamed: aString [
	^ self class slotDefinitionNamed: aString
]

{ #category : #'slot definitions' }
LcsDomainObject >> slotModel [
	^ self class slotModel
]
