Class {
	#name : 'LcsLabelSlot',
	#superclass : 'LcsStringSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsLabelSlot >> initialize [
	super initialize.
	self slotName: 'label'
]
