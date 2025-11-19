Class {
	#name : 'LcsLocation',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'locationName',
		'address'
	],
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'slot definitions' }
LcsLocation class >> addressSlotDefinition [
	<slotDefinition>
	^ LcsAddressSlot new
]

{ #category : 'slot definitions' }
LcsLocation class >> locationNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'locationName';
		yourself
]

{ #category : 'accessing' }
LcsLocation >> address [
	^ self slotVarNamed: 'address'
]

{ #category : 'accessing' }
LcsLocation >> address: anObject [ 
	self slotVarNamed: 'address' put: anObject
]

{ #category : 'accessing' }
LcsLocation >> locationName [
	^ self slotVarNamed: 'locationName'
]

{ #category : 'accessing' }
LcsLocation >> locationName: anObject [ 
	self slotVarNamed: 'locationName' put: anObject
]
