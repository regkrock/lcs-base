Class {
	#name : #LcsSlotDoesNotExistInSlotModelError,
	#superclass : #LcsError,
	#instVars : [
		'context',
		'slotName'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'instance creation' }
LcsSlotDoesNotExistInSlotModelError class >> signalWithContext: anObject [ 
	self new
		context: anObject;
		signal: 'Slot model not initialized for ' , anObject className
]

{ #category : #slots }
LcsSlotDoesNotExistInSlotModelError class >> signalWithContext: anObject slotName: aSlotName [ 
	self new
		signalWithContext: anObject slotName: aSlotName
			
]

{ #category : #accessing }
LcsSlotDoesNotExistInSlotModelError >> context [
	^ context
]

{ #category : #accessing }
LcsSlotDoesNotExistInSlotModelError >> context: anObject [
	context := anObject
]

{ #category : #'gt view' }
LcsSlotDoesNotExistInSlotModelError >> gtCurrentSystemViewFor: aView [
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

{ #category : #'gt view' }
LcsSlotDoesNotExistInSlotModelError >> gtDomainClassViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Domain';
		priority: 20;
		object: [ self context ];
		view: #gtMetaFor:
]

{ #category : #slots }
LcsSlotDoesNotExistInSlotModelError >> signalWithContext: anObject slotName: aSlotName [ 
	self context: anObject.
	self slotName: aSlotName.
	self signal: ('Slot ' , self slotName printString  , ' not defined in slot model') 
]

{ #category : #slots }
LcsSlotDoesNotExistInSlotModelError >> slotName [
	^ slotName
]

{ #category : #slots }
LcsSlotDoesNotExistInSlotModelError >> slotName: aSlotName [ 
	slotName := aSlotName
]
