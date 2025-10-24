Class {
	#name : #LcsUserToUserIdConversionSlot,
	#superclass : #LcsObjectToIdConversionSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsUserToUserIdConversionSlot >> initialize [
	super initialize.
	self slotName: 'user'.
	self targetSlotName: 'userUuid'.
	self convertFromTarget: [ :userUuid | self securityModule userWithUuid: userUuid ].
	self convertToTarget: [ :user | user uuid ]
]
