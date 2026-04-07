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
LcsPasswordSlot >> alphabet [
	^ Character alphabet
]

{ #category : 'initialize' }
LcsPasswordSlot >> initialize [
	super initialize.
	self slotName: 'password'.
	self beAllowInitialNull.
	self beRequired.
	"self validationRules beAndEvaluationType."
	self addValidationRule: self passwordValidationRule
]

{ #category : 'initialize' }
LcsPasswordSlot >> passwordValidationRule [
	^ LcsValidationRule new
		conditionBlock: [ :value :domainObject :oldValue | 
			value size >= 8 and: [ 
			(value includesAnyOf: self specialCharacters) and: [
			(value includesAnyOf: self alphabet) and: [ 
			(value includesAnyOf: self uppercaseAlphabet) and: [
			(value includesAnyOf: '1234567890') ] ] ] ] ];
		description: 'Password is required';
		errorMessage: 'Password must be least 8 characters long and include at least one number, one special character (' , Character specialCharacters , ') and one uppercase character';
		yourself
]

{ #category : 'initialize' }
LcsPasswordSlot >> specialCharacters [
	^ '+-/\*~<>=@,%|&?!·÷±×#$'
]

{ #category : 'initialize' }
LcsPasswordSlot >> uppercaseAlphabet [
	^ Character alphabet asUppercase
]
