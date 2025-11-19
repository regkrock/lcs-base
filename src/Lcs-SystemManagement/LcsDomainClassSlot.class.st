Class {
	#name : 'LcsDomainClassSlot',
	#superclass : 'LcsSmalltalkObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'configuration' }
LcsDomainClassSlot >> addDefaultSlotType [
	"Do nothing"
]

{ #category : 'initialize' }
LcsDomainClassSlot >> convertStringToClassBlock [
	^ [ :value | [ value isClass ifTrue: [ value ] ifFalse: [ value asClass ] ] on: NotFound do: [ :s | s return: value ] ]
]

{ #category : 'defaults' }
LcsDomainClassSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | slot slotTypes any ]
]

{ #category : 'initialize' }
LcsDomainClassSlot >> initialize [
	super initialize.
	self 
		prevalidationTransformBlock: self convertStringToClassBlock;
		addValidationCondition: (
			LcsValidationCondition new
				validationDescription: 'Input class is not a valid subclass';
				errorMessage: ['This must be a subclass of <1s>' expandMacrosWith: self superclassClass name ];
				conditionBlock: [ :value | (value inheritsFrom:  self superclassClass) not ] ;
				yourself)
]

{ #category : 'properties' }
LcsDomainClassSlot >> superclassClass [
	^ self properties at: 'superclassClass' ifAbsent: [ LcsDomainObject ]
]

{ #category : 'properties' }
LcsDomainClassSlot >> superclassClass: aClass [
	self properties at: 'superclassClass' put: aClass
]

{ #category : 'slot model' }
LcsDomainClassSlot >> typeClass [
	"Slot type must be explicitly added via #addSlotTYpe: "
	^ nil
]

{ #category : 'slot model' }
LcsDomainClassSlot >> verifySlotTypeOf: anObject for: aDomainObject [
	(self slotTypes includes: anObject) ifFalse: [
		self signalInvalidSlotTypeError: anObject for: aDomainObject]
]
