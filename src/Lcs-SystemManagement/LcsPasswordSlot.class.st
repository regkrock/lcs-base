Class {
	#name : 'LcsPasswordSlot',
	#superclass : 'LcsStringSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'configuration' }
LcsPasswordSlot >> allowInitialNullRule [
	^ super allowInitialNullRule
		errorMessage: 'Password is required';
		yourself
]

{ #category : 'initialize' }
LcsPasswordSlot >> initialize [
	super initialize.
	self slotName: 'password'.
	self beAllowInitialNull.
	self beRequired.
	self addValidationRule: (
			LcsValidationRule new
				conditionBlock: [ :value :domainObject : oldValue | value notEmpty];
				description: 'Password is required')
]
