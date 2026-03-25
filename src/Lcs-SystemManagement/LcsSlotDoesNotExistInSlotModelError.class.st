Class {
	#name : 'LcsSlotDoesNotExistInSlotModelError',
	#superclass : 'LcsSlotModelError',
	#category : 'Lcs-SystemManagement-Error',
	#package : 'Lcs-SystemManagement',
	#tag : 'Error'
}

{ #category : 'slots' }
LcsSlotDoesNotExistInSlotModelError class >> signalWithSlotModel: aSlotModel slotName: aSlotName [ 
	self new
		signalWithSlotModel: aSlotModel slotName: aSlotName
			
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
LcsSlotDoesNotExistInSlotModelError >> signalWithSlotModel: aSlotModel slotName: aSlotName [ 
	self context: aSlotModel.
	self slotName: aSlotName.
	self signal: ('Slot ' , self slotName printString  , ' not defined in slot model') 
]
