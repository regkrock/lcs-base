Class {
	#name : #LcsSlotModelError,
	#superclass : #LcsError,
	#instVars : [
		'context',
		'slotName'
	],
	#category : #'Lcs-SystemManagement-Error'
}

{ #category : #accessing }
LcsSlotModelError >> context [
	^ context
]

{ #category : #accessing }
LcsSlotModelError >> context: anObject [
	context := anObject
]

{ #category : #'gt view' }
LcsSlotModelError >> gtCurrentSystemViewFor: aView [
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
