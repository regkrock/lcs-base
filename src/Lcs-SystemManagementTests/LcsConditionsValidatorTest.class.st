Class {
	#name : #LcsConditionsValidatorTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#category : #'Lcs-SystemManagementTests'
}

{ #category : #'as yet unclassified' }
LcsConditionsValidatorTest >> testValidatingPerson [
	<TODO: 'Add code to validate all slots'>
	| result |
	self subject: LxxPerson new.
	result := self subject validateSlots.
]
