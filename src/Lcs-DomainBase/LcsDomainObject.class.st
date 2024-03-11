Class {
	#name : #LcsDomainObject,
	#superclass : #LcsObject,
	#instVars : [
		'parent'
	],
	#classInstVars : [
		'SlotDefinitions'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #'slot definitions' }
LcsDomainObject class >> addSlotDefinitions [
	self slotDefinitionMethods do: [ :eachPragma | 
			self slotDefinitions addSlotDefinition: (self perform: eachPragma methodSelector) ]
]

{ #category : #'unit of work' }
LcsDomainObject class >> addToUnitOfWork: newObject [
	self currentUnitOfWork addObject: newObject
]

{ #category : #'unit of work' }
LcsDomainObject class >> currentUnitOfWork [
	^self currentSystem currentUnitOfWork
]

{ #category : #'slot definitions' }
LcsDomainObject class >> initializeSlotDefinitions [
	self slotDefinitions: (LcsSlotDefinitions newOn: self).
	self addSlotDefinitions
]

{ #category : #'instance creation\t' }
LcsDomainObject class >> new [
	| newObject |
	newObject := self basicNew initialize.
	self currentSystem ifNotNil: [self addToUnitOfWork: newObject].
	^ newObject
]

{ #category : #'slot definitions' }
LcsDomainObject class >> slotDefinitionMethods [
	^ Pragma allNamed: 'slotDefinition' in: self class
]

{ #category : #'slot definitions' }
LcsDomainObject class >> slotDefinitionNamed: aString [ 
	^self slotDefinitions slotDefinitionNamed: aString
]

{ #category : #accessing }
LcsDomainObject class >> slotDefinitions [
	^ SlotDefinitions
]

{ #category : #accessing }
LcsDomainObject class >> slotDefinitions: anObject [
	SlotDefinitions := anObject
]

{ #category : #'unit of work' }
LcsDomainObject >> currentUnitOfWork [

	^ self class currentUnitOfWork
]

{ #category : #'unit of work' }
LcsDomainObject >> delete [

	self currentUnitOfWork deleteObject: self
]

{ #category : #'slot definitions' }
LcsDomainObject >> getValueOfSlotNamed: aSlotName [
	^ (self slotDefinitionNamed: aSlotName) getValueIn: self
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

{ #category : #accessing }
LcsDomainObject >> slotDefinitions [
	^ self class slotDefinitions
]

{ #category : #accessing }
LcsDomainObject >> slotDefintions [
	^ self class slotDefinitions
]

{ #category : #validation }
LcsDomainObject >> validateConfiguration [
	self assert: self slotDefintions class name equals: #LcsSlotDefinitions.
	self slotDefintions validateConfiguration
]
