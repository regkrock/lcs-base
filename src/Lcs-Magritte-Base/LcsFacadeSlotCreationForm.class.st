Class {
	#name : #LcsFacadeSlotCreationForm,
	#superclass : #LcsSlotCreationForm,
	#category : #'Lcs-Magritte-Base-Forms - Models'
}

{ #category : #configuration }
LcsFacadeSlotCreationForm class >> defaultSlotClass [
	^ LcsFacadeSlot
]

{ #category : #configuration }
LcsFacadeSlotCreationForm class >> priority [
	^ 20
]

{ #category : #configuration }
LcsFacadeSlotCreationForm class >> slotComponentName [
	^ 'Facade'
]

{ #category : #callbacks }
LcsFacadeSlotCreationForm >> commit [
	self halt: 'Need to create slot definition, etc'
]
