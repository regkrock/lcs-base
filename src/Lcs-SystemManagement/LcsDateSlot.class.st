Class {
	#name : #LcsDateSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsDateSlot >> defaultInitialValueBlock [ 
	^ [ self typeClass today ]
]

{ #category : #'default ui component' }
LcsDateSlot >> defaultInputComponentClassName [
	^ #'LuiDatePicker'
]

{ #category : #configuration }
LcsDateSlot >> typeClass [
	^ LcsSmalltalkConfiguration dateClass
]
