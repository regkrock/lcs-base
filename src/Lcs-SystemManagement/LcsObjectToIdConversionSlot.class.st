Class {
	#name : #LcsObjectToIdConversionSlot,
	#superclass : #LcsFacadeSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #properties }
LcsObjectToIdConversionSlot >> convertFromTarget [
	^ self propertyAt: 'convertFromTarget' ifAbsent: [ ]
]

{ #category : #properties }
LcsObjectToIdConversionSlot >> convertFromTarget: anObject [
	self propertyAt: 'convertFromTarget' put: anObject
]

{ #category : #properties }
LcsObjectToIdConversionSlot >> convertToTarget [
	^ self propertyAt: 'convertToTarget' ifAbsent: [ ]
]

{ #category : #properties }
LcsObjectToIdConversionSlot >> convertToTarget: anObject [
	self propertyAt: 'convertToTarget' put: anObject
]

{ #category : #'slot access' }
LcsObjectToIdConversionSlot >> currentSlotVarIn: aDomainObject [
	^ self convertFromTarget 
		cull: (aDomainObject slotVarNamed: self targetSlotName) 
		cull: aDomainObject
]

{ #category : #'slot access' }
LcsObjectToIdConversionSlot >> slotVarPut: anObject in: aTargetDomainObject [
	aTargetDomainObject
		slotVarNamed: self targetSlotName
		put: (self convertToTarget cull: anObject  cull: aTargetDomainObject)
]
