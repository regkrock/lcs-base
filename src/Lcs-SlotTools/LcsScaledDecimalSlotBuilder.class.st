Class {
	#name : #LcsScaledDecimalSlotBuilder,
	#superclass : #LcsAccessorSlotBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsScaledDecimalSlotBuilder class >> slotClass [
	^ LcsScaledDecimalSlot
]

{ #category : #properties }
LcsScaledDecimalSlotBuilder >> numberOfDecimals [
	^ self propertyAt: 'numberOfDecimals'
]

{ #category : #properties }
LcsScaledDecimalSlotBuilder >> numberOfDecimals: anInteger [
	self propertyAt: 'numberOfDecimals' put: anInteger
]

{ #category : #magritte }
LcsScaledDecimalSlotBuilder >> numberOfDecimalsDescription [
	^ MANumberDescription new
		label: 'Number Of Decimals';
		beInteger;
		accessor: (MAPluggableAccessor
				read: [ :aModel | self numberOfDecimals ]
				write: [ :aModel :aValue | self numberOfDecimals: aValue ]);
		min: 0;
		max: 8;
		yourself
]
