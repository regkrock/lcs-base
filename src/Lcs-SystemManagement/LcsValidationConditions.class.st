Class {
	#name : #LcsValidationConditions,
	#superclass : #LcsApplicationObject,
	#traits : 'LtParentTrait + LtDictionaryCollection',
	#classTraits : 'LtParentTrait classTrait + LtDictionaryCollection classTrait',
	#instVars : [
		'conditions'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #conditions }
LcsValidationConditions >> addValidationCondition: aValidationCondition [
	aValidationCondition parent: self.
	self at: aValidationCondition description put: aValidationCondition
]

{ #category : #conditions }
LcsValidationConditions >> addValidationCondition: aBlock description: aString [
	self addValidationCondition: (
		LcsValidationCondition new
			description: aString;
			conditionBlock: aBlock;
			yourself)
]

{ #category : #initialize }
LcsValidationConditions >> initialize [ 
	super initialize.
	self collection: OrderedDictionary new
]

{ #category : #conditions }
LcsValidationConditions >> removeValidationCondition: aCondition [
	self removeValidationConditionWithDescription: aCondition description
]

{ #category : #conditions }
LcsValidationConditions >> removeValidationConditionWithDescription: aString [
	self removeKey: aString ifAbsent: []
]

{ #category : #'slot model' }
LcsValidationConditions >> slotDefinition [
	^ self parent
]

{ #category : #conditions }
LcsValidationConditions >> validate: aValue [
	self collection do: [ :eachCondition | eachCondition validate: aValue ]
	
]

{ #category : #conditions }
LcsValidationConditions >> validate: aValue context: aDomainObject [
	self collection do: [ :eachCondition | eachCondition validate: aValue context: aDomainObject ]
	
]
