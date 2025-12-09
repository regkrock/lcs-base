Class {
	#name : 'LcsPostAddActions',
	#superclass : 'LcsSlotActions',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'magritte' }
LcsPostAddActions >> actionClass [
	^ LcsPostAddAction
]

{ #category : 'magritte' }
LcsPostAddActions >> actionsLabel [
	^ 'Post Add Actions'
]

{ #category : 'conditions' }
LcsPostAddActions >> execute: aValue [
	self collection do: [ :eachAction| eachAction execute: aValue ]
]

{ #category : 'conditions' }
LcsPostAddActions >> execute: aValue context: aDomainObject [
	self collection do: [ :eachAction | eachAction execute: aValue context: aDomainObject ]
	
]

{ #category : 'conditions' }
LcsPostAddActions >> execute: aValue context: aDomainObject oldValue: anOldValue [
	self collection do: [ :eachAction | eachAction execute: aValue context: aDomainObject oldValue: anOldValue ]
]

{ #category : 'magritte' }
LcsPostAddActions >> postAddActionsDescription [
	<magritteDescription>
	^ self actionsDescription
]

{ #category : 'conditions' }
LcsPostAddActions >> removePostAddAction: aPostAddAction [
	^ self remove: aPostAddAction ifAbsent: []
]
