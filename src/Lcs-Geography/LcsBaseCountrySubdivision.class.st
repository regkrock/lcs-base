Class {
	#name : 'LcsBaseCountrySubdivision',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'isoCode',
		'formalName',
		'subdivisionName'
	],
	#category : 'Lcs-Geography-Domain',
	#package : 'Lcs-Geography',
	#tag : 'Domain'
}

{ #category : 'asking' }
LcsBaseCountrySubdivision class >> collectionSlotIn: anObject [ 
	^ anObject perform: self parentSlotDefinition collectionSlotName asSymbol
]

{ #category : 'slot definition' }
LcsBaseCountrySubdivision class >> formalNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #formalName;
		beRequired;
		addValidationCondition: [ :value :domainObject :oldValue | value size <= 2 ] description: 'Name must be at least 3 characters long';
		yourself
]

{ #category : 'slot definition\t' }
LcsBaseCountrySubdivision class >> isoCodeSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'isoCode';
		beRequired;
		addValidationCondition: [ :value :domainObject :oldValue | value size ~= 2 ] description: 'Code must be 2 characters long';		yourself
]

{ #category : 'slot definition' }
LcsBaseCountrySubdivision class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionReferenceSlot new
			slotName: 'parent';
			collectionSlotName: 'subdivisions';
			addSlotType: LcsCountrySubdivisions;
			yourself
]

{ #category : 'slot definition' }
LcsBaseCountrySubdivision class >> subdivisionNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #subdivisionName;
		beRequired;
		addValidationCondition: [ :value :domainObject :oldValue | value size <= 2 ] description: 'Name must be at least 3 characters long';
		yourself
]

{ #category : 'accessing' }
LcsBaseCountrySubdivision >> formalName [
	^ self slotVarNamed: 'formalName'
]

{ #category : 'accessing' }
LcsBaseCountrySubdivision >> formalName: anObject [
	self slotVarNamed: 'formalName' put: anObject
]

{ #category : 'accessing' }
LcsBaseCountrySubdivision >> isoCode [
	^ self slotVarNamed: 'isoCode'
]

{ #category : 'accessing' }
LcsBaseCountrySubdivision >> isoCode: anObject [
	self slotVarNamed: 'isoCode' put: anObject
]

{ #category : 'accessing' }
LcsBaseCountrySubdivision >> subdivisionName [
	^ self slotVarNamed: 'subdivisionName'
]

{ #category : 'accessing' }
LcsBaseCountrySubdivision >> subdivisionName: anObject [
	self slotVarNamed: 'subdivisionName' put: anObject
]
