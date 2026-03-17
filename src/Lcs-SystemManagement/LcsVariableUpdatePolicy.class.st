Class {
	#name : 'LcsVariableUpdatePolicy',
	#superclass : 'LcsObject',
	#instVars : [
		'parent'
	],
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'instance creation' }
LcsVariableUpdatePolicy class >> newOn: aSlotDefinition [
	^ self new
		parent: aSlotDefinition;
		yourself
]

{ #category : 'system' }
LcsVariableUpdatePolicy >> currentUnitOfWork [
	^ self parent currentUnitOfWork
]

{ #category : 'acccessing' }
LcsVariableUpdatePolicy >> parent [
	^ parent
]

{ #category : 'acccessing' }
LcsVariableUpdatePolicy >> parent: aSlotDefinition [
	parent := aSlotDefinition
]

{ #category : 'validation' }
LcsVariableUpdatePolicy >> validate: anObject [
	self parent validate: anObject
]

{ #category : 'validation' }
LcsVariableUpdatePolicy >> validate: anObject context: aDomainObject [
	self parent validate: anObject context: aDomainObject
]

{ #category : 'validation' }
LcsVariableUpdatePolicy >> validate: anObject context: aDomainObject oldValue: anOldvalue [
	self parent validate: anObject context: aDomainObject oldValue: anOldvalue
]
