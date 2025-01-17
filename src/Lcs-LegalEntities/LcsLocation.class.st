Class {
	#name : #LcsLocation,
	#superclass : #LcsDomainObject,
	#instVars : [
		'locationName',
		'address'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definition' }
LcsLocation class >> addressSlotDefinition [
	<slotDefinition>
	^ LcsAggregateSlot new
		slotName: 'address';
		yourself
]

{ #category : #'slot definition' }
LcsLocation class >> locationNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'locationName';
		yourself
]

{ #category : #accessing }
LcsLocation >> address [
	^ self getValueOfSlotNamed: 'address'
]

{ #category : #accessing }
LcsLocation >> address: anObject [ 
	self setValueOfSlotNamed: 'address' to: anObject
]

{ #category : #accessing }
LcsLocation >> locationName [
	^ self getValueOfSlotNamed: 'locationName'
]

{ #category : #accessing }
LcsLocation >> locationName: anObject [ 
	self setValueOfSlotNamed: 'locationName' to: anObject
]
