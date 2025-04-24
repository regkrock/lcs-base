Class {
	#name : #LcsSingletonLabelSlot,
	#superclass : #LcsLabelSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsSingletonLabelSlot >> initialize [
	super initialize.
	self initialValueBlock: [ :anInstance | anInstance class defaultLabel ]
]
