Class {
	#name : 'LcsSlotTypeRules',
	#superclass : 'LcsBaseRules',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'comparing' }
LcsSlotTypeRules >> = aRules [
	(aRules isKindOf: LcsSlotTypeRules) ifFalse: [ ^ false ].
	^ self collection = aRules collection
]

{ #category : 'comparing' }
LcsSlotTypeRules >> hash [
	^ self collection inject: self identityHash into: [ :each :hash | hash bitXor: each hash ]
]

{ #category : 'configuration' }
LcsSlotTypeRules >> ruleClass [
	^ LcsBaseSlotTypeRule
]

{ #category : 'validations' }
LcsSlotTypeRules >> validate: aValue context: aDomainObject oldValue: anOldValue [
	self collection isEmpty ifTrue: [ 
		LcsInvalidSlotTypeError 
			signalNoRulesToValidateType: aValue
			forSlot: self slotDefinition
			for: nil ].
	self collection do: [ :eachValidation | (eachValidation validate: aValue context: aDomainObject oldValue: anOldValue) ifTrue: [ ^ true ] ].
	^ true
]

{ #category : 'magritte' }
LcsSlotTypeRules >> validationRulesDescriptionClasses [
	^ { LcsValidationRule }
]
