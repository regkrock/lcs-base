Class {
	#name : 'LcsPostRemoveActions',
	#superclass : 'LcsSlotActions',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'magritte' }
LcsPostRemoveActions >> actionClass [
	^ LcsPostRemoveAction
]

{ #category : 'magritte' }
LcsPostRemoveActions >> actionsLabel [
	^ 'Post Remove Actions'
]

{ #category : 'conditions' }
LcsPostRemoveActions >> execute: aValue [
	self collection do: [ :eachAction| eachAction execute: aValue ]
]

{ #category : 'conditions' }
LcsPostRemoveActions >> execute: aValue context: aDomainObject [
	self collection do: [ :eachAction | eachAction execute: aValue context: aDomainObject ]
	
]

{ #category : 'conditions' }
LcsPostRemoveActions >> execute: aValue context: aDomainObject oldValue: anOldValue [
	self collection do: [ :eachAction | eachAction execute: aValue context: aDomainObject oldValue: anOldValue ]
]

{ #category : 'magritte' }
LcsPostRemoveActions >> postRemoveActionsDescription [
	<magritteDescription>
	^ self actionsDescription
]
