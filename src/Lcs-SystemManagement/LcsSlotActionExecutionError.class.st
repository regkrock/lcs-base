Class {
	#name : 'LcsSlotActionExecutionError',
	#superclass : 'LcsSlotModelError',
	#instVars : [
		'value',
		'updateAction',
		'slotDefinition',
		'oldValue',
		'smalltalkException'
	],
	#category : 'Lcs-SystemManagement-Error',
	#package : 'Lcs-SystemManagement',
	#tag : 'Error'
}

{ #category : 'instance creation' }
LcsSlotActionExecutionError class >> signalErrorForValue: anUpdateAction updateAction: aValue slot: aSlotDefinition context: aDomainObject oldValue: anOldValue smalltalkException: aSmalltalkException [
	^ self new
		signalErrorForValue: anUpdateAction
		updateAction: aValue
		slot: aSlotDefinition
		context: aDomainObject
		oldValue: anOldValue
		smalltalkException: aSmalltalkException
]

{ #category : 'accessing' }
LcsSlotActionExecutionError >> oldValue [
	^ oldValue
]

{ #category : 'accessing' }
LcsSlotActionExecutionError >> oldValue: anObject [
	oldValue := anObject
]

{ #category : 'error' }
LcsSlotActionExecutionError >> signalErrorForValue: anUpdateAction updateAction: aValue slot: aSlotDefinition context: aDomainObject oldValue: anOldValue smalltalkException: aSmalltalkException [ 
	self value: aValue.
	self updateAction: anUpdateAction.
	self slotDefinition: aSlotDefinition.
	self context: aDomainObject.
	self oldValue: anOldValue.
	self smalltalkException: aSmalltalkException.
	self signal: self updateAction errorDescription  , ': ' , aSmalltalkException message printString.
]

{ #category : 'accessing' }
LcsSlotActionExecutionError >> slotDefinition [
	^ slotDefinition
]

{ #category : 'accessing' }
LcsSlotActionExecutionError >> slotDefinition: anObject [
	slotDefinition := anObject
]

{ #category : 'accessing' }
LcsSlotActionExecutionError >> smalltalkException [
	^ smalltalkException
]

{ #category : 'accessing' }
LcsSlotActionExecutionError >> smalltalkException: anObject [
	smalltalkException := anObject
]

{ #category : 'accessing' }
LcsSlotActionExecutionError >> updateAction [
	^ updateAction
]

{ #category : 'accessing' }
LcsSlotActionExecutionError >> updateAction: anObject [
	updateAction := anObject
]

{ #category : 'accessing' }
LcsSlotActionExecutionError >> value [
	^ value
]

{ #category : 'accessing' }
LcsSlotActionExecutionError >> value: aValue [ 
	value := aValue
]
