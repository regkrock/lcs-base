Class {
	#name : 'LcsDateSlot',
	#superclass : 'LcsBaseSmalltalkObjectSlot',
	#traits : 'LtRangeRule',
	#classTraits : 'LtRangeRule classTrait',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsDateSlot >> defaultInitialValueBlock [ 
	^ [ :parentDomainObject :slot | self typeClass today ]
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
	^ Date
]
