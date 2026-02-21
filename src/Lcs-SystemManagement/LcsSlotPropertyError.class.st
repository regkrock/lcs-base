Class {
	#name : 'LcsSlotPropertyError',
	#superclass : 'LcsSlotModelError',
	#instVars : [
		'slotDefinition'
	],
	#category : 'Lcs-SystemManagement-Error',
	#package : 'Lcs-SystemManagement',
	#tag : 'Error'
}

{ #category : 'gt views' }
LcsSlotPropertyError >> gtSlotPropertiesView: aView [
	<gtView>
	<gtExceptionView>
	^aView forward
		title: 'Slot Properties';
		priority: 2;
		object: [ self slotDefinition ];
		view: #gtSlotPropertiesViewFor:
]

{ #category : 'accessing' }
LcsSlotPropertyError >> slotDefinition [
	^ slotDefinition
]

{ #category : 'accessing' }
LcsSlotPropertyError >> slotDefinition: anObject [
	slotDefinition := anObject
]
