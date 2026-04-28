Class {
	#name : 'LcsSlotDefinitionError',
	#superclass : 'LcsError',
	#instVars : [
		'context',
		'slotName'
	],
	#category : 'Lcs-SystemManagement-Error',
	#package : 'Lcs-SystemManagement',
	#tag : 'Error'
}

{ #category : 'accessing' }
LcsSlotDefinitionError >> context [
	^ context
]

{ #category : 'accessing' }
LcsSlotDefinitionError >> context: anObject [
	context := anObject
]

{ #category : 'gt view' }
LcsSlotDefinitionError >> gtCurrentSystemViewFor: aView [
	<gtView>
	<gtExceptionView>
	self currentSystem ifNil: [ 
		^ aView list
			title: 'No Current System';
			priority: 20;
			items: [ {'No current system'} ]; 
			yourself].
	^ aView forward
		title: 'Current System';
		priority: 20;
		object: [ self currentSystem ];
		view: #gtMetaFor:
]

{ #category : 'accessing' }
LcsSlotDefinitionError >> slotName [
	^ slotName
]

{ #category : 'accessing' }
LcsSlotDefinitionError >> slotName: aString [
	slotName := aString
]
