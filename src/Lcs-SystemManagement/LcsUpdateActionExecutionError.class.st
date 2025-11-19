Class {
	#name : 'LcsUpdateActionExecutionError',
	#superclass : 'LcsSlotModelError',
	#instVars : [
		'value',
		'updateAction',
		'slotDefinition',
		'oldValue'
	],
	#category : 'Lcs-SystemManagement-Error',
	#package : 'Lcs-SystemManagement',
	#tag : 'Error'
}

{ #category : 'instance creation' }
LcsUpdateActionExecutionError class >> signalErrForValue: aValue updateAction: anUpdateAction slot: aSlotDefinition context: aDomainObject oldValue: anOldValue message: aMessage [ 
	^ self new signalErrForValue: aValue updateAction: anUpdateAction slot: aSlotDefinition context: aDomainObject oldValue: anOldValue message: aMessage 
]

{ #category : 'accessing' }
LcsUpdateActionExecutionError >> oldValue [
	^ oldValue
]

{ #category : 'accessing' }
LcsUpdateActionExecutionError >> oldValue: anObject [
	oldValue := anObject
]

{ #category : 'error' }
LcsUpdateActionExecutionError >> signalErrForValue: aValue updateAction: anUpdateAction slot: aSlotDefinition context: aDomainObject oldValue: anOldValue message: aString [ 
	self value: aValue.
	self updateAction: anUpdateAction.
	self slotDefinition: aSlotDefinition.
	self context: aDomainObject.
	self oldValue: anOldValue.
	self signal: self updateAction errorDescription  , ': ' , aString.
]

{ #category : 'accessing' }
LcsUpdateActionExecutionError >> slotDefinition [
	^ slotDefinition
]

{ #category : 'accessing' }
LcsUpdateActionExecutionError >> slotDefinition: anObject [
	slotDefinition := anObject
]

{ #category : 'accessing' }
LcsUpdateActionExecutionError >> updateAction [
	^ updateAction
]

{ #category : 'accessing' }
LcsUpdateActionExecutionError >> updateAction: anObject [
	updateAction := anObject
]

{ #category : 'accessing' }
LcsUpdateActionExecutionError >> value [
	^ value
]

{ #category : 'accessing' }
LcsUpdateActionExecutionError >> value: aValue [ 
	value := aValue
]
