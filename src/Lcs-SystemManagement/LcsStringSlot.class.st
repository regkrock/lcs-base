Class {
	#name : #LcsStringSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsStringSlot >> defaultInitialValueBlock [
	^ [ self typeClass new ]
]

{ #category : #'as yet unclassified' }
LcsStringSlot >> defaultInputComponentClassName [
	^#LuiTextInput
]

{ #category : #initialize }
LcsStringSlot >> initialize [
	super initialize.
	self addSlotType: self typeClass
]

{ #category : #configuration }
LcsStringSlot >> typeClass [
	<todo: 'This needs to use UTF-8 string calss'> 
	^ LcsSmalltalkConfiguration stringClass
]
