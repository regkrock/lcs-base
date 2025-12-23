Class {
	#name : 'LcsDateRange',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'effectiveDate',
		'expiryDate'
	],
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsDateRange class >> effectiveDateSlotDefinition [
	<accessorSlotDefinition>
	^ LcsDateSlot new
		slotName: 'effectiveDate';
		initialValueBlock: [ :parentDomainParent :slot | 
			Date
				newDay: 1
				month: 1
				year: 1970 ];
		yourself
]

{ #category : 'slot definitions' }
LcsDateRange class >> expiryDateSlotDefinition [
	<accessorSlotDefinition>
	^ LcsDateSlot new
		slotName: 'expiryDate';
		initialValueBlock: [ :parentDomainParent :slot | 
			Date
				newDay: 31
				month: 12
				year: 2100 ];
		yourself
]

{ #category : 'slot definitions' }
LcsDateRange class >> isInEffectSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlot new
			slotName: 'isInEffect';
			addSlotType: Boolean;
			valueAccessor: #_isInEffect;
			yourself
]

{ #category : 'testing' }
LcsDateRange >> _isInEffect [
	^ self isInEffectOn: Date today
]

{ #category : 'accessing' }
LcsDateRange >> effectiveDate [
	^ self slotVarNamed: 'effectiveDate'
]

{ #category : 'accessing' }
LcsDateRange >> effectiveDate: anObject [
	self slotVarNamed: 'effectiveDate' put: anObject
]

{ #category : 'accessing' }
LcsDateRange >> expiryDate [
	^ self slotVarNamed: 'expiryDate'
]

{ #category : 'accessing' }
LcsDateRange >> expiryDate: anObject [
	self slotVarNamed: 'expiryDate' put: anObject
]

{ #category : 'accessing' }
LcsDateRange >> isInEffect [
	^ self slotVarNamed: 'isInEffect'
]

{ #category : 'testing' }
LcsDateRange >> isInEffectOn: aDate [
	^ aDate >= self effectiveDate and: [ aDate <= self expiryDate ]
]
