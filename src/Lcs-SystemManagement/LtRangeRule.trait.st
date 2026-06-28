Trait {
	#name : 'LtRangeRule',
	#category : 'Lcs-SystemManagement-Traits',
	#package : 'Lcs-SystemManagement',
	#tag : 'Traits'
}

{ #category : 'properties' }
LtRangeRule >> maximum [
	^ self maximumBlock value
]

{ #category : 'properties' }
LtRangeRule >> maximum: aMagnitude [
	self propertyAt: #maximumBlock put: [ aMagnitude ].
	self validationRules addRule: LcsRangeRule new 
]

{ #category : 'properties' }
LtRangeRule >> maximumBlock [
	^ self propertyAt: #maximumBlock ifAbsent: [ nil ]
]

{ #category : 'properties' }
LtRangeRule >> maximumBlock: aBlock [
	self propertyAt: #maximumBlock put: aBlock.
	self validationRules addRule: LcsRangeRule new
]

{ #category : 'properties' }
LtRangeRule >> minimum [
	^ self minimumBlock value
]

{ #category : 'properties' }
LtRangeRule >> minimum: aMagnitude [
	self propertyAt: #minimumBlock put: [ aMagnitude ].
	self validationRules addRule: LcsRangeRule new 
]

{ #category : 'properties' }
LtRangeRule >> minimumBlock [
	^ self propertyAt: #minimumBlock ifAbsent: [ nil ]
]

{ #category : 'properties' }
LtRangeRule >> minimumBlock: aBlock [
	self propertyAt: #minimumBlock put: aBlock.
	self validationRules addRule: LcsRangeRule new
]

{ #category : 'validation rule' }
LtRangeRule >> rangeRule [
	^ self validationRules detect: [ :each | each class name = #LcsRangeRule ]
]

{ #category : 'validation rule' }
LtRangeRule >> rangeRuleErrorMessage: aString [
	self rangeRule ifNotNil: [ :rule | rule errorMessage: aString ]
]
