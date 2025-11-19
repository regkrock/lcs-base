Class {
	#name : 'LcsSlotDoesNotExistInSlotModelError',
	#superclass : 'LcsSlotModelError',
	#category : 'Lcs-SystemManagement-Error',
	#package : 'Lcs-SystemManagement',
	#tag : 'Error'
}

{ #category : 'instance creation' }
LcsSlotDoesNotExistInSlotModelError class >> signalWithContext: anObject [ 
	self new
		context: anObject;
		signal: 'Slot model not initialized for ' , anObject className
]

{ #category : 'slots' }
LcsSlotDoesNotExistInSlotModelError class >> signalWithContext: anObject slotName: aSlotName [ 
	self new
		signalWithContext: anObject slotName: aSlotName
			
]

{ #category : 'gt view' }
LcsSlotDoesNotExistInSlotModelError >> gtDomainClassViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Domain Class';
		priority: 20;
		object: [ self context parent ];
		view: #gtMetaFor:
]

{ #category : 'slots' }
LcsSlotDoesNotExistInSlotModelError >> signalWithContext: anObject slotName: aSlotName [ 
	self context: anObject.
	self slotName: aSlotName.
	self signal: ('Slot ' , self slotName printString  , ' not defined in slot model') 
]

{ #category : 'slots' }
LcsSlotDoesNotExistInSlotModelError >> slotName [
	^ slotName
]

{ #category : 'slots' }
LcsSlotDoesNotExistInSlotModelError >> slotName: aSlotName [ 
	slotName := aSlotName
]
