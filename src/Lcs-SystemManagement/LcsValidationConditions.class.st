Class {
	#name : #LcsValidationConditions,
	#superclass : #LcsApplicationObject,
	#traits : 'LtParentTrait + LtDictionaryCollection',
	#classTraits : 'LtParentTrait classTrait + LtDictionaryCollection classTrait',
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'hashing\t' }
LcsValidationConditions >> = aValidationCollections [
	(aValidationCollections isKindOf: LcsValidationConditions) ifFalse: [ ^ false ].
	"self collection size = aValidationCollections collections size ifFalse: [ ^ false ]."
	^ self collection = aValidationCollections collection
]

{ #category : #conditions }
LcsValidationConditions >> addValidationCondition: aValidationCondition [
	aValidationCondition parent: self.
	self at: aValidationCondition validationDescription put: aValidationCondition
]

{ #category : #conditions }
LcsValidationConditions >> addValidationCondition: aBlock description: aString [
	self addValidationCondition: (
		LcsValidationCondition new
			validationDescription: aString;
			conditionBlock: aBlock;
			yourself)
]

{ #category : #'hashing\t' }
LcsValidationConditions >> hash [
	^ self collection inject: self identityHash into: [ :each :hash | hash bitXor: each hash ]
]

{ #category : #initialize }
LcsValidationConditions >> initialize [ 
	super initialize.
	self collection: OrderedDictionary new
]

{ #category : #conditions }
LcsValidationConditions >> removeValidationCondition: aCondition [
	self removeValidationConditionWithDescription: aCondition validationDescription
]

{ #category : #conditions }
LcsValidationConditions >> removeValidationConditionWithDescription: aString [
	^ self removeKey: aString ifAbsent: []
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

{ #category : #querying }
LcsValidationConditions >> validationConditionWithDescription: aString [
	^ self at: aString ifAbsent: [ ]
]
