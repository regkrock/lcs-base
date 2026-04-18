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

{ #category : 'default ui component' }
LcsStringSlot >> defaultInputComponentClassName [
	^#LuiTextInput
]

{ #category : 'iniitialize' }
LcsStringSlot >> initialValue: anObject [
	super initialValue:anObject printString
]

{ #category : 'testing' }
LcsStringSlot >> isNullObject: anObject [ 
	^ anObject isString and: [ anObject isEmpty ]
]

{ #category : 'configuration' }
LcsStringSlot >> typeClass [
	<todo: 'This needs to use UTF-8 string calss'> 
	^ LcsSmalltalkConfiguration stringClass
]
