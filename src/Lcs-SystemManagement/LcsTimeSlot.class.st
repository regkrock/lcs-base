Class {
	#name : 'LcsTimeSlot',
	#superclass : 'LcsBaseSmalltalkObjectSlot',
	#traits : 'LtRangeRule',
	#classTraits : 'LtRangeRule classTrait',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'configuration' }
LcsTimeSlot >> configureWidgetComponent: aWidgetComponent [
	aWidgetComponent 
		"step: self stepValue;"
		min: (self minimum ifNotNil: [ :time | time asString ]) ;
		max: (self maximum ifNotNil: [ :time | time asString ]) 
]

{ #category : 'defaults' }
LcsTimeSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | slot typeClass now ]
]

{ #category : 'initialize' }
LcsTimeSlot >> initialize [
	super initialize.
	self slotName: 'time'
]

{ #category : 'defaults' }
LcsTimeSlot >> typeClass [
	^ LcsSmalltalkConfiguration timeClass 
]
