Class {
	#name : #LcsAddress,
	#superclass : #LcsDomainObject,
	#instVars : [
		'streetName',
		'postalCode'
	],
	#category : #'Lcs-Geography-Domain'
}

{ #category : #'slot definitions' }
LcsAddress class >> postalCodeSlotDefinition [
	<slotDefinition>
	^ LcsAccessorSlot new
		slotName: 'postalCode';
		required: true;
		slotTypes: (OrderedCollection with: LcsPostalCode);
		initialValueBlock: '[ :parentDomainObject | 
		(self slotTypes any new)
			parent: parentDomainObject;
			yourself ]';
		yourself
]

{ #category : #'slot definitions' }
LcsAddress class >> streetNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'streetName';
		slotTypes: (OrderedCollection with: String);
		initialValueBlock: '[ '''' ]';
		yourself
]

{ #category : #accessing }
LcsAddress >> postalCode [
	^ self slotVarNamed: 'postalCode'
]

{ #category : #accessing }
LcsAddress >> postalCode: anObject [
	self slotVarNamed: 'postalCode' put: anObject
]

{ #category : #accessing }
LcsAddress >> streetName [
	^ self slotVarNamed: 'streetName'
]

{ #category : #accessing }
LcsAddress >> streetName: anObject [
	self slotVarNamed: 'streetName' put: anObject
]
