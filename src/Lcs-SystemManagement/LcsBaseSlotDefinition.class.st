Class {
	#name : #LcsBaseSlotDefinition,
	#superclass : #LcsApplicationObject,
	#instVars : [
		'slotName',
		'parent',
		'slotTypes',
		'domainClass',
		'validationConditions',
		'priority'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #configuration }
LcsBaseSlotDefinition >> addSlotType: aClass [
	(self slotTypes includes: aClass) ifFalse: [ self slotTypes add: aClass ]
]

{ #category : #validations }
LcsBaseSlotDefinition >> addValidationCondition: aValidationCondition [
	self validationConditions addValidationCondition: aValidationCondition
]

{ #category : #validations }
LcsBaseSlotDefinition >> addValidationCondition: aBlock description: aString [
	self validationConditions addValidationCondition: aBlock description: aString
]

{ #category : #configuration }
LcsBaseSlotDefinition >> clearSlotTypes [
	self slotTypes removeAll.
]

{ #category : #'slot model' }
LcsBaseSlotDefinition >> domainClass [
	^ domainClass ifNil: [ domainClass := self parent domainClass ]
]

{ #category : #'slot model' }
LcsBaseSlotDefinition >> domainClass: aDomainClass [
	domainClass := aDomainClass
]

{ #category : #initialize }
LcsBaseSlotDefinition >> initialize [
	super initialize.
	self initializeSlotTypes.
	self validationConditions: (LcsValidationConditions newOn: self).
	self priority: 50
]

{ #category : #initialize }
LcsBaseSlotDefinition >> initializeSlotTypes [
	self slotTypes: OrderedCollection new
]

{ #category : #'slot model' }
LcsBaseSlotDefinition >> label [
	^self labelForSelector: self slotName
]

{ #category : #accessing }
LcsBaseSlotDefinition >> parent [
	^ parent
]

{ #category : #accessing }
LcsBaseSlotDefinition >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
LcsBaseSlotDefinition >> priority [
	^ priority
]

{ #category : #accessing }
LcsBaseSlotDefinition >> priority: anObject [
	priority := anObject
]

{ #category : #validations }
LcsBaseSlotDefinition >> removeValidationCondition: aValidationCondition [
	self validationConditions removeValidationCondition: aValidationCondition
]

{ #category : #validations }
LcsBaseSlotDefinition >> removeValidationConditionWithDescription: aString [
	self validationConditions removeValidationConditionWithDescription: aString
]

{ #category : #defaults }
LcsBaseSlotDefinition >> slotClass [
	^ self slotTypes any
]

{ #category : #accessing }
LcsBaseSlotDefinition >> slotName [
	^ slotName
]

{ #category : #accessing }
LcsBaseSlotDefinition >> slotName: anObject [
	slotName := anObject
]

{ #category : #'gt views' }
LcsBaseSlotDefinition >> slotTypeClassNames [
	| stream |
	stream := WriteStream on: String new.
	self slotTypes do: [ :eachClass |
		stream nextPutAll: (
			eachClass isClass 
				ifTrue: [ eachClass name displayString ] 
				ifFalse: [ eachClass printString ])  ] separatedBy: [ stream nextPutAll: ', '].
	^stream contents
]

{ #category : #accessing }
LcsBaseSlotDefinition >> slotTypes [
	^ slotTypes
]

{ #category : #accessing }
LcsBaseSlotDefinition >> slotTypes: anObject [
	slotTypes := anObject
]

{ #category : #'slot model' }
LcsBaseSlotDefinition >> slotVarPut: anObject in: aDomainObject [
	^ LcsError signal: 'Attempt to update a read only slot'
]

{ #category : #validations }
LcsBaseSlotDefinition >> validate: aValue [
	(LcsConditionsValidator newOn: self)
		validate: aValue
]

{ #category : #validations }
LcsBaseSlotDefinition >> validate: aValue context: aDomainObject [
	(LcsConditionsValidator newOn: self)
		validate: aValue context: aDomainObject
]

{ #category : #accessing }
LcsBaseSlotDefinition >> validationConditions [
	^ validationConditions
]

{ #category : #accessing }
LcsBaseSlotDefinition >> validationConditions: anObject [
	validationConditions := anObject
]
