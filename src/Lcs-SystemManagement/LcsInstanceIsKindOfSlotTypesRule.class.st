Class {
	#name : 'LcsInstanceIsKindOfSlotTypesRule',
	#superclass : 'LcsBaseSlotTypeRule',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsInstanceIsKindOfSlotTypesRule >> defaultAuditMessage [
	^ 'Invalid slot type'
]

{ #category : 'defaults' }
LcsInstanceIsKindOfSlotTypesRule >> defaultConditionBlock [
	^ [ :value :parentDomainObject :oldValue | 
	self slotTypes
		detect: [ :eachClass | value isKindOf: eachClass ]
		ifNone: [  
			LcsInvalidSlotTypeError 
				signalInvalidType: value 
				rule: self 
				inSlot: self slotDefinition 
				context: parentDomainObject ].
	true ]
]

{ #category : 'defaults' }
LcsInstanceIsKindOfSlotTypesRule >> defaultDescription [
	^ 'Instance''s class not in slot types list'
]

{ #category : 'defaults' }
LcsInstanceIsKindOfSlotTypesRule >> defaultErrorMessage [
	^ '<1s> class is not in the slot types list' expandMacrosWith: (self slotDefinition ifNil: [ '<nil>' ])
]

{ #category : 'slot' }
LcsInstanceIsKindOfSlotTypesRule >> slotTypes [
	^ self slotDefinition 
		ifNil: [ ^ #() ]
		ifNotNil: [ self slotDefinition slotTypes ]
]
