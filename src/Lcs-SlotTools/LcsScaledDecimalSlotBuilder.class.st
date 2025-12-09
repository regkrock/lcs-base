Class {
	#name : 'LcsScaledDecimalSlotBuilder',
	#superclass : 'LcsSmalltalkObjectSlotBuilder',
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'configuration' }
LcsScaledDecimalSlotBuilder class >> slotClass [
	^ LcsScaledDecimalSlot
]

{ #category : 'properties' }
LcsScaledDecimalSlotBuilder >> numberOfDecimals [
	^ self propertyAt: 'numberOfDecimals'
]

{ #category : 'properties' }
LcsScaledDecimalSlotBuilder >> numberOfDecimals: anInteger [
	self propertyAt: 'numberOfDecimals' put: anInteger
]

{ #category : 'magritte' }
LcsScaledDecimalSlotBuilder >> numberOfDecimalsDescription [
	<magritteDescription>
	^ MANumberDescription new
		label: 'Number Of Decimals';
		beInteger;
		priority: 11;
		"Using pluggable adaptor as it works with the delegation. Regular accessor does not"
		accessor: #numberOfDecimals;
		min: 0;
		max: 8;
		yourself
]
