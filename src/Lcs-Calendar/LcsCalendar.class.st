Class {
	#name : 'LcsCalendar',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'inEffectDateRange'
	],
	#category : 'Lcs-Calendar',
	#package : 'Lcs-Calendar'
}

{ #category : 'slot definitions' }
LcsCalendar class >> effectiveDateSlotDefinition [
	<facadeSlotDefinition>
	^ LcsDelegatorSlot new
			slotName: 'effectiveDate';
			addSlotType: Date;
			targetSlotPath: #(#inEffectDateRange #effectiveDate) asOrderedCollection;
			yourself
]

{ #category : 'slot definitions' }
LcsCalendar class >> expiryDateSlotDefinition [
	<facadeSlotDefinition>
	^ LcsDelegatorSlot new
		slotName: 'expiryDate';
		addSlotType: Date;
		targetSlotPath: #(#inEffectDateRange #expiryDate) asOrderedCollection;
		yourself
]

{ #category : 'slot definitions' }
LcsCalendar class >> inEffectDateRangeSlotDefinition [
	<accessorSlotDefinition>
	^ LcsDateRangeSlot new
			slotName: 'inEffectDateRange';
			yourself
]

{ #category : 'accessing' }
LcsCalendar >> effectiveDate [
	^ self slotVarNamed: 'effectiveDate'
]

{ #category : 'accessing' }
LcsCalendar >> effectiveDate: anObject [
	self slotVarNamed: 'effectiveDate' put: anObject
]

{ #category : 'accessing' }
LcsCalendar >> expiryDate [
	^ self slotVarNamed: 'expiryDate'
]

{ #category : 'accessing' }
LcsCalendar >> expiryDate: anObject [
	self slotVarNamed: 'expiryDate' put: anObject
]

{ #category : 'accessing' }
LcsCalendar >> inEffectDateRange [
	^ self slotVarNamed: 'inEffectDateRange'
]

{ #category : 'accessing' }
LcsCalendar >> inEffectDateRange: anObject [
	self slotVarNamed: 'inEffectDateRange' put: anObject
]

{ #category : 'testing' }
LcsCalendar >> isInEffect [
	^ self inEffectDateRange isInEffect
]
