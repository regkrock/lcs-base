Class {
	#name : 'LcsPasswordSlot',
	#superclass : 'LcsStringSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsPasswordSlot >> initialize [
	super initialize.
	self slotName: 'password'.
	self beAllowInitialNull.
	self beRequired.
	self addValidationRule: (
			LcsValidationRule new
				conditionBlock: [ :value :domainObject : oldValue | value notEmpty];
				description: 'pasword is required')
]
