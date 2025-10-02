Class {
	#name : #LcsDateSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsDateSlot >> defaultInitialValueBlock [ 
	^ [ :domainObject :slot | self typeClass today ]
]

{ #category : #defaults }
LcsDateSlot >> defaultInputComponentClassName [
	^ #'LuiDatePicker'
]

{ #category : #defaults }
LcsDateSlot >> defaultPrevalidationTransformBlock [
	^ [ :value :slot | 
		(value isKindOf: Date) 
			ifTrue: [ value ]
			ifFalse: [ 
				[ Date fromString: value ]
					on: Error
					do: [ :s | s return: value ] ] ]
]

{ #category : #configuration }
LcsDateSlot >> typeClass [
	^ LcsSmalltalkConfiguration dateClass
]
