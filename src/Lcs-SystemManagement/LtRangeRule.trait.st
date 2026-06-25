Trait {
	#name : 'LtRangeRule',
	#instVars : [
		''
	],
	#category : 'Lcs-SystemManagement-Traits',
	#package : 'Lcs-SystemManagement',
	#tag : 'Traits'
}

{ #category : 'properties' }
LtRangeRule >> maximum [
	^ self propertyAt: #maximum ifAbsent: [ nil ]
]

{ #category : 'properties' }
LtRangeRule >> maximum: aMagnitude [
	self propertyAt: #maximum put: aMagnitude.
	aMagnitude notNil ifTrue: [ self validationRules addRule: LcsRangeRule new ]
]

{ #category : 'properties' }
LtRangeRule >> minimum [
	^ self propertyAt: #minimum ifAbsent: [ nil ]
]

{ #category : 'properties' }
LtRangeRule >> minimum: aMagnitude [
	self propertyAt: #minimum put: aMagnitude.
	aMagnitude notNil ifTrue: [
		self validationRules addRule: LcsRangeRule new ]
]

{ #category : 'validation rule' }
LtRangeRule >> rangeRule [
	^ self validationRules detect: [ :each | each class name = #LcsRangeRule ]
]

{ #category : 'validation rule' }
LtRangeRule >> rangeRuleErrorMessage: aString [
	self rangeRule ifNotNil: [ :rule | rule errorMessage: aString ]
]
