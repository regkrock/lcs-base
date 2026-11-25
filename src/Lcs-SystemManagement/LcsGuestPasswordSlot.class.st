Class {
	#name : 'LcsGuestPasswordSlot',
	#superclass : 'LcsPasswordSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsGuestPasswordSlot >> initialize [
	super initialize.
	self beAllowNull
]

{ #category : 'initialize' }
LcsGuestPasswordSlot >> passwordValidationRule [
	^ LcsValidationRule new
		conditionBlock: [ :value :domainObject :oldValue | value = '' ];
		description: 'Password is not required';
		errorMessage: 'Guest User does not require a password';
		yourself
]
