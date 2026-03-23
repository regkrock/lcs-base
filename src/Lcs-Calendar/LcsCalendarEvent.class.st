Class {
	#name : 'LcsCalendarEvent',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'effective',
		'expiry',
		'title',
		'description',
		'location'
	],
	#category : 'Lcs-Calendar-Core',
	#package : 'Lcs-Calendar',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsCalendarEvent class >> descriptionSlotDefinition [
	<accessorSlotDefinition>
	^ LcsTextSlot new
		slotName: 'description';
		yourself
]

{ #category : 'slot definitions' }
LcsCalendarEvent class >> effectiveSlotDefinition [
	<accessorSlotDefinition>
	^ LcsDateAndTimeSlot new
		slotName: 'effective';
		required: true;
		initialValueBlock: [ :parentDomainObject :slot | 
			| now |
			now := DateAndTime now.
			slot slotTypes any year: now year month: now month day: now dayOfMonth hour: now hour minute: 0 ];
		comment: 'This is the effective date and time of calendar event';
		yourself
]

{ #category : 'slot definitions' }
LcsCalendarEvent class >> expirySlotDefinition [
	<accessorSlotDefinition>
	^ LcsDateAndTimeSlot new
		slotName: 'expiry';
		required: true;
		initialValueBlock: [ :parentDomainObject :slot | 
			| now |
			now := DateAndTime now.
			slot slotTypes any year: now year month: now month day: now dayOfMonth hour: now hour + 1 minute: 0 ];
		comment: 'The date and time that the event is over';
		yourself
]

{ #category : 'slot definitions' }
LcsCalendarEvent class >> locationSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
			slotName: 'location';
			yourself
]

{ #category : 'slot definitions' }
LcsCalendarEvent class >> titleSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
			slotName: 'title';
			yourself
]

{ #category : 'accessing' }
LcsCalendarEvent >> description [
	^ self slotVarNamed: 'description'
]

{ #category : 'accessing' }
LcsCalendarEvent >> description: anObject [
	self slotVarNamed: 'description' put: anObject
]

{ #category : 'accessing' }
LcsCalendarEvent >> effective [
	^ self slotVarNamed: 'effective'
]

{ #category : 'accessing' }
LcsCalendarEvent >> effective: anObject [
	self slotVarNamed: 'effective' put: anObject
]

{ #category : 'accessing' }
LcsCalendarEvent >> expiry [
	^ self slotVarNamed: 'expiry'
]

{ #category : 'accessing' }
LcsCalendarEvent >> expiry: anObject [
	self slotVarNamed: 'expiry' put: anObject
]

{ #category : 'accessing' }
LcsCalendarEvent >> location [
	^ self slotVarNamed: 'location'
]

{ #category : 'accessing' }
LcsCalendarEvent >> location: anObject [
	self slotVarNamed: 'location' put: anObject
]

{ #category : 'accessing' }
LcsCalendarEvent >> title [
	^ self slotVarNamed: 'title'
]

{ #category : 'accessing' }
LcsCalendarEvent >> title: anObject [
	self slotVarNamed: 'title' put: anObject
]
