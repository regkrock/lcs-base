Class {
	#name : #LcsVariableUpdatePolicy,
	#superclass : #LcsObject,
	#instVars : [
		'parent'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'instance creation' }
LcsVariableUpdatePolicy class >> newOn: aSlotDefinition [
	^ self new
		parent: aSlotDefinition;
		yourself
]

{ #category : #system }
LcsVariableUpdatePolicy >> currentUnitOfWork [
	^ self parent currentUnitOfWork
]

{ #category : #acccessing }
LcsVariableUpdatePolicy >> parent [
	^ parent
]

{ #category : #acccessing }
LcsVariableUpdatePolicy >> parent: aSlotDefinition [
	parent := aSlotDefinition
]
