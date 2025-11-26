Class {
	#name : 'LxxBaseCountrySubdivision',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'isoCode',
		'formalName',
		'subdivisionName'
	],
	#category : 'Lcs-PrototypeSystem-Base',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Base'
}

{ #category : 'slot definition' }
LxxBaseCountrySubdivision class >> formalNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'formalName';
		addValidationCondition: [ :value :domainObject :oldValue | value size < 3 ] description: 'Must be 3 characters';
		yourself
]

{ #category : 'slot definition' }
LxxBaseCountrySubdivision class >> isoCodeSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'isoCode';
		addValidationCondition: [ :value :domainObject :oldValue | value size ~= 2 ] description: 'Must be 2 characters';
		yourself
]

{ #category : 'instance creation' }
LxxBaseCountrySubdivision class >> newInContextOf: anObject [
	| newObject parentCollectionSlot|
	newObject := self basicNew.
	self currentSystem ifNotNil: [
		"parentCollectionSlot := self collectionSlotIn: anObject."
		parentCollectionSlot := anObject perform: self parentSlotDefinition collectionSlotName asSymbol.
		self currentUnitOfWork addObject: newObject toCollection: parentCollectionSlot ].
	newObject initialize.
	^ newObject 
]

{ #category : 'slot definition' }
LxxBaseCountrySubdivision class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionReferenceSlot new
			slotName: 'parent';
			addSlotType: LxxCountrySubdivisions;
			collectionSlotName: 'subdivisions';
			yourself
]

{ #category : 'slot definition' }
LxxBaseCountrySubdivision class >> subdivisionNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'subdivisionName';
		addValidationCondition: [ :value :domainObject :oldValue | value size < 2 ] description: 'Must be at least 2 characters';
		yourself
]

{ #category : 'accessing' }
LxxBaseCountrySubdivision >> formalName [
	^ self slotVarNamed: 'formalName'
]

{ #category : 'accessing' }
LxxBaseCountrySubdivision >> formalName: anObject [
	self slotVarNamed: 'formalName' put: anObject
]

{ #category : 'accessing' }
LxxBaseCountrySubdivision >> isoCode [
	^ self slotVarNamed: 'isoCode'
]

{ #category : 'accessing' }
LxxBaseCountrySubdivision >> isoCode: anObject [
	self slotVarNamed: 'isoCode' put: anObject
]

{ #category : 'accessing' }
LxxBaseCountrySubdivision >> subdivisionName [
	^ self slotVarNamed: 'subdivisionName'
]

{ #category : 'accessing' }
LxxBaseCountrySubdivision >> subdivisionName: anObject [
	self slotVarNamed: 'subdivisionName' put: anObject
]
