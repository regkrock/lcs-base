Class {
	#name : 'LcsValidationRules',
	#superclass : 'LcsBaseRules',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'comparing' }
LcsValidationRules >> = aValidationCollections [
	(aValidationCollections isKindOf: LcsValidationRules) ifFalse: [ ^ false ].
	"self collection size = aValidationCollections collections size ifFalse: [ ^ false ]."
	^ self collection = aValidationCollections collection
]

{ #category : 'comparing' }
LcsValidationRules >> hash [
	^ self collection inject: self identityHash into: [ :each :hash | hash bitXor: each hash ]
]

{ #category : 'configuration' }
LcsValidationRules >> ruleClass [
	^ LcsValidationRule
]

{ #category : 'magritte' }
LcsValidationRules >> validationRulesDescriptionClasses [
	^ { LcsValidationRule }
]
