Class {
	#name : #LcsVirtualSlotCreationForm,
	#superclass : #LcsSlotCreationForm,
	#category : #'Lcs-Magritte-Base-Forms - Models'
}

{ #category : #configuration }
LcsVirtualSlotCreationForm class >> defaultSlotClass [
	^ LcsVirtualSlot
]

{ #category : #configuration }
LcsVirtualSlotCreationForm class >> priority [
	^ 30
]

{ #category : #configuration }
LcsVirtualSlotCreationForm class >> slotComponentName [
	^ 'Virtual'
]

{ #category : #callbacks }
LcsVirtualSlotCreationForm >> commit [
	self halt: 'Need to create slot definition, etc'
]
