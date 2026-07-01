Class {
	#name : 'LcsStringSlot',
	#superclass : 'LcsBaseSmalltalkObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsStringSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | self typeClass new ]
]

{ #category : 'testing' }
LcsStringSlot >> isNullObject: anObject [ 
	^ anObject isString and: [ anObject isEmpty ]
]

{ #category : 'properties' }
LcsStringSlot >> pattern [
	^ self propertyAt: #'pattern' ifAbsent: [ nil ]
]

{ #category : 'properties' }
LcsStringSlot >> pattern: aRexexString [
	self propertyAt: #'pattern' put: aRexexString
]

{ #category : 'configuration' }
LcsStringSlot >> typeClass [
	<todo: 'This needs to use UTF-8 string calss'> 
	^ LcsSmalltalkConfiguration stringClass
]
