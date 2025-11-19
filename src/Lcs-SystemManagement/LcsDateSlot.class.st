Class {
	#name : 'LcsDateSlot',
	#superclass : 'LcsSmalltalkObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsDateSlot >> defaultInitialValueBlock [ 
	^ [ :parentDomainObject :slot | self typeClass today ]
]

{ #category : 'defaults' }
LcsDateSlot >> defaultInputComponentClassName [
	^ #'LuiDatePicker'
]

{ #category : 'defaults' }
LcsDateSlot >> defaultPrevalidationTransformBlock [
	^ [ :value :slot | 
		(value isKindOf: Date) 
			ifTrue: [ value ]
			ifFalse: [ 
				[ Date fromString: value ]
					on: Error
					do: [ :s | s return: value ] ] ]
]

{ #category : 'configuration' }
LcsDateSlot >> typeClass [
	^ LcsSmalltalkConfiguration dateClass
]
