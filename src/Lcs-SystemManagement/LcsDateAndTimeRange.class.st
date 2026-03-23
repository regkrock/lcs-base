Class {
	#name : 'LcsDateAndTimeRange',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'effective',
		'expiry'
	],
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsDateAndTimeRange class >> effectiveSlotDefinition [
	<accessorSlotDefinition>
	^ LcsDateAndTimeSlot new
		slotName: 'effective';
		initialValueBlock: [ :parentDomainParent :slot | 
			DateAndTime now];
		yourself
]

{ #category : 'slot definitions' }
LcsDateAndTimeRange class >> expirySlotDefinition [
	<accessorSlotDefinition>
	^ LcsDateSlot new
		slotName: 'expiry';
		initialValueBlock: [ :parentDomainParent :slot | 
			DateAndTime now ];
		yourself
]

{ #category : 'slot definitions' }
LcsDateAndTimeRange class >> isInEffectSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlot new
			slotName: 'isInEffect';
			addSlotType: Boolean;
			valueAccessor: #_isInEffect;
			yourself
]

{ #category : 'testing' }
LcsDateAndTimeRange >> _isInEffect [
	^ self isInEffectOn: DateAndTime now
]

{ #category : 'accessing' }
LcsDateAndTimeRange >> effective [
	^ self slotVarNamed: 'effective'
]

{ #category : 'accessing' }
LcsDateAndTimeRange >> effective: aDateAndTime [
	self slotVarNamed: 'effective' put: aDateAndTime
]

{ #category : 'accessing' }
LcsDateAndTimeRange >> expiry [
	^ self slotVarNamed: 'expiry'
]

{ #category : 'accessing' }
LcsDateAndTimeRange >> expiry: aDateAndTime [
	self slotVarNamed: 'expiry' put: aDateAndTime
]

{ #category : 'printing' }
LcsDateAndTimeRange >> gtDisplayOn: stream [
	self gtPrint: self effective yyyymmdd , ' - ' , self expiry yyyymmdd on: stream
]

{ #category : 'accessing' }
LcsDateAndTimeRange >> isInEffect [
	^ self slotVarNamed: 'isInEffect'
]

{ #category : 'testing' }
LcsDateAndTimeRange >> isInEffectOn: aDateAndTime [
	^ aDateAndTime >= self effective and: [ aDateAndTime <= self expiry ]
]
